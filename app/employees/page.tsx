"use client";

import Link from "next/link";
import React, { useMemo, useState } from "react";

type Employee = {
  id: string;
  firstName: string;
  lastName: string;
  status: "Active" | "Inactive";
  position: string;
  town?: string;
  phone?: string;
};

const seed: Employee[] = [
  { id: "14", firstName: "Aleksandr", lastName: "Shevchenko", status: "Active", position: "HMK, CP, PCA", town: "Newington", phone: "(860) 977-8906" },
  { id: "22", firstName: "Maria", lastName: "Lopez", status: "Active", position: "PCA", town: "Bristol", phone: "(860) 555-0123" },
  { id: "31", firstName: "John", lastName: "Miller", status: "Inactive", position: "HM", town: "Berlin", phone: "(860) 555-0199" },
];

export default function EmployeesPage() {
  const [query, setQuery] = useState("");
  const [status, setStatus] = useState<"All" | Employee["status"]>("All");

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    return seed
      .filter((e) => (status === "All" ? true : e.status === status))
      .filter((e) => {
        if (!q) return true;
        const hay = `${e.id} ${e.firstName} ${e.lastName} ${e.position} ${e.town ?? ""}`.toLowerCase();
        return hay.includes(q);
      })
      .sort((a, b) => a.lastName.localeCompare(b.lastName));
  }, [query, status]);

  return (
    <div className="min-h-screen bg-slate-50">
      <div className="sticky top-0 z-20 border-b border-slate-200 bg-white/80 backdrop-blur">
        <div className="mx-auto max-w-7xl px-4 py-4">
          <div className="flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
            <div>
              <div className="flex items-center gap-3">
                <Link href="/" className="text-sm font-semibold text-slate-600 hover:text-slate-900">
                  ← Switchboard
                </Link>
                <span className="text-slate-300">/</span>
                <span className="text-sm font-semibold text-slate-900">Employees</span>
              </div>
              <h1 className="mt-2 text-2xl font-semibold tracking-tight">Employees</h1>
              <p className="mt-1 text-sm text-slate-600">
                Search and open an employee record (modern version of the Access selector screen).
              </p>
            </div>

            <div className="flex flex-wrap gap-2">
              <button
                className="h-10 rounded-xl bg-emerald-600 px-4 text-sm font-semibold text-white hover:bg-emerald-700"
                type="button"
                onClick={() => alert("Add New (wire to create flow later)")}
              >
                Add New
              </button>
              <button
                className="h-10 rounded-xl bg-white px-4 text-sm font-semibold text-slate-900 ring-1 ring-slate-200 hover:bg-slate-50"
                type="button"
                onClick={() => {
                  setQuery("");
                  setStatus("All");
                }}
              >
                Display All
              </button>
              <button
                className="h-10 rounded-xl bg-white px-4 text-sm font-semibold text-slate-900 ring-1 ring-slate-200 hover:bg-slate-50"
                type="button"
                onClick={() => alert("Management Reports (placeholder)")}
              >
                Management Reports
              </button>
              <button
                className="h-10 rounded-xl bg-rose-600 px-4 text-sm font-semibold text-white hover:bg-rose-700"
                type="button"
                onClick={() => alert("Exit (placeholder)")}
              >
                Exit
              </button>
            </div>
          </div>

          <div className="mt-4 grid gap-3 md:grid-cols-[1fr_180px]">
            <div className="rounded-2xl bg-white p-3 ring-1 ring-slate-200">
              <input
                value={query}
                onChange={(e) => setQuery(e.target.value)}
                placeholder="Search by name, ID, position, town…"
                className="h-11 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
              />
            </div>

            <div className="rounded-2xl bg-white p-3 ring-1 ring-slate-200">
              <select
                value={status}
                onChange={(e) => setStatus(e.target.value as any)}
                className="h-11 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
              >
                <option value="All">All statuses</option>
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
              </select>
            </div>
          </div>
        </div>
      </div>

      <div className="mx-auto max-w-7xl px-4 py-6">
        <div className="rounded-2xl bg-white ring-1 ring-slate-200 overflow-hidden">
          <div className="border-b border-slate-100 px-4 py-3 text-sm font-semibold text-slate-900">Edit / View</div>

          <div className="divide-y divide-slate-100">
            {filtered.map((e) => (
              <Link
                key={e.id}
                href={`/employees/${encodeURIComponent(e.id)}`}
                className="flex flex-col gap-2 px-4 py-4 hover:bg-slate-50 transition"
              >
                <div className="flex items-center gap-3">
                  <div className="h-10 w-10 rounded-2xl bg-slate-900/5 ring-1 ring-slate-200 grid place-items-center text-sm font-semibold text-slate-700">
                    {e.firstName[0]}
                    {e.lastName[0]}
                  </div>
                  <div className="min-w-0">
                    <div className="text-sm font-semibold text-slate-900">
                      {e.lastName}, {e.firstName} <span className="text-slate-400">•</span>{" "}
                      <span className="text-slate-700">#{e.id}</span>
                    </div>
                    <div className="mt-0.5 text-sm text-slate-600 truncate">
                      {e.position}
                      {e.town ? ` • ${e.town}` : ""}
                      {e.phone ? ` • ${e.phone}` : ""}
                    </div>
                  </div>
                  <div className="ml-auto flex items-center gap-2">
                    <span
                      className={`rounded-full px-2.5 py-1 text-xs font-semibold ring-1 ${
                        e.status === "Active"
                          ? "bg-emerald-50 text-emerald-700 ring-emerald-200"
                          : "bg-slate-50 text-slate-700 ring-slate-200"
                      }`}
                    >
                      {e.status}
                    </span>
                    <span className="text-slate-400 text-lg">→</span>
                  </div>
                </div>
              </Link>
            ))}
            {filtered.length === 0 && (
              <div className="px-4 py-10 text-center text-sm text-slate-600">No employees match your search.</div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
