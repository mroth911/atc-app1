"use client";

import Link from "next/link";
import { signIn } from "next-auth/react";
import React, { useState } from "react";

export default function LoginPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setBusy(true);
    setError(null);

    const res = await signIn("credentials", {
      email,
      password,
      redirect: false,
    });

    setBusy(false);

    if (res?.error) {
      setError("Invalid email or password.");
      return;
    }

    window.location.href = "/";
  }

  return (
    <div className="min-h-screen bg-slate-50 grid place-items-center p-6">
      <div className="w-full max-w-md rounded-3xl bg-white p-6 ring-1 ring-slate-200">
        <div className="flex items-center justify-between">
          <div>
            <div className="text-sm font-semibold text-slate-600">HomeMaker • Web</div>
            <h1 className="mt-1 text-2xl font-semibold tracking-tight text-slate-900">Sign in</h1>
          </div>
          <Link href="/" className="text-sm font-semibold text-slate-600 hover:text-slate-900">
            ← Back
          </Link>
        </div>

        <form onSubmit={onSubmit} className="mt-6 grid gap-3">
          <div>
            <div className="text-xs font-medium text-slate-600">Email</div>
            <input
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              type="email"
              autoComplete="email"
              className="mt-1 h-11 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
              placeholder="admin@example.com"
              required
            />
          </div>

          <div>
            <div className="text-xs font-medium text-slate-600">Password</div>
            <input
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              type="password"
              autoComplete="current-password"
              className="mt-1 h-11 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
              placeholder="••••••••"
              required
            />
          </div>

          {error && (
            <div className="rounded-2xl bg-rose-50 p-3 text-sm text-rose-700 ring-1 ring-rose-200">
              {error}
            </div>
          )}

          <button
            type="submit"
            disabled={busy}
            className="mt-2 h-11 rounded-xl bg-emerald-600 px-4 text-sm font-semibold text-white hover:bg-emerald-700 disabled:opacity-60"
          >
            {busy ? "Signing in..." : "Sign in"}
          </button>

          <p className="mt-2 text-xs text-slate-500">
            Admin access is required for <span className="font-semibold">/admin</span>.
          </p>
        </form>
      </div>
    </div>
  );
}
