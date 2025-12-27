"use client";

import React, { useEffect, useState } from "react";

type User = {
  id: string;
  name: string | null;
  email: string | null;
  role: "admin" | "user";
};

export default function AdminPage() {
  const [users, setUsers] = useState<User[]>([]);
  const [error, setError] = useState<string | null>(null);

  const [email, setEmail] = useState("");
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [role, setRole] = useState<"admin" | "user">("user");

  async function load() {
    setError(null);
    const r = await fetch("/api/admin/users");
    const d = await r.json().catch(() => null);

    if (!r.ok) {
      setUsers([]);
      setError(d?.error ?? `Failed to load users (${r.status})`);
      return;
    }

    if (!Array.isArray(d)) {
      setUsers([]);
      setError("Unexpected API response from /api/admin/users");
      return;
    }

    setUsers(d);
  }

  useEffect(() => { load(); }, []);

  async function createUser() {
    setError(null);
    const r = await fetch("/api/admin/users", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, name, password, role }),
    });

    const d = await r.json().catch(() => null);
    if (!r.ok) {
      setError(d?.error ?? `Create user failed (${r.status})`);
      return;
    }

    setEmail("");
    setName("");
    setPassword("");
    setRole("user");
    load();
  }

  async function toggleRole(id: string, current: string) {
    await fetch(`/api/admin/users/${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ role: current === "admin" ? "user" : "admin" }),
    });
    load();
  }

  async function resetPassword(id: string) {
    const p = prompt("New password (min 8 chars)");
    if (!p) return;

    await fetch(`/api/admin/users/${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ password: p }),
    });
    load();
  }

  return (
    <div className="min-h-screen bg-slate-50 p-6">
      <div className="max-w-4xl mx-auto space-y-6">
        <h1 className="text-2xl font-semibold">Admin Panel</h1>

        {error && (
          <div className="rounded-2xl bg-rose-50 p-4 text-sm text-rose-800 ring-1 ring-rose-200">
            {error}
          </div>
        )}

        <div className="bg-white p-4 rounded-2xl ring-1">
          <h2 className="font-semibold mb-2">Create User</h2>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-2">
            <input value={name} onChange={e=>setName(e.target.value)} placeholder="Name" className="border rounded-xl px-3 h-10"/>
            <input value={email} onChange={e=>setEmail(e.target.value)} placeholder="Email" className="border rounded-xl px-3 h-10"/>
            <input value={password} onChange={e=>setPassword(e.target.value)} placeholder="Password" type="password" className="border rounded-xl px-3 h-10"/>
            <select value={role} onChange={e=>setRole(e.target.value as any)} className="border rounded-xl px-3 h-10">
              <option value="user">User</option>
              <option value="admin">Admin</option>
            </select>
          </div>
          <button onClick={createUser} className="mt-3 bg-emerald-600 text-white px-4 h-10 rounded-xl">
            Create
          </button>
        </div>

        <div className="bg-white rounded-2xl ring-1 divide-y">
          {users.map(u => (
            <div key={u.id} className="p-4 flex items-center gap-3">
              <div className="flex-1">
                <div className="font-semibold">{u.email}</div>
                <div className="text-sm text-slate-600">{u.name ?? "—"} • {u.role}</div>
              </div>
              <button onClick={()=>toggleRole(u.id, u.role)} className="border rounded-xl px-3 h-9">Toggle Admin</button>
              <button onClick={()=>resetPassword(u.id)} className="border rounded-xl px-3 h-9">Reset Password</button>
            </div>
          ))}
          {users.length === 0 && !error && (
            <div className="p-4 text-sm text-slate-600">No users found.</div>
          )}
        </div>
      </div>
    </div>
  );
}