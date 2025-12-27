"use client";

import Link from "next/link";
import { useEffect, useState } from "react";

type ClientRow = {
  SSN: string;
  FirstName: string | null;
  LastName: string | null;
  Phone: string | null;
  Town: string | null;
  State: string | null;
};

export default function ClientsPage() {
  const [q, setQ] = useState("");
  const [rows, setRows] = useState<ClientRow[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function load(search = "") {
    setLoading(true);
    setError(null);
    const res = await fetch(`/api/clients?q=${encodeURIComponent(search)}`, { cache: "no-store" });
    const data = await res.json().catch(() => null);

    if (!res.ok) {
      setRows([]);
      setError(data?.details ?? data?.error ?? `Failed (${res.status})`);
    } else {
      setRows(Array.isArray(data) ? data : []);
    }
    setLoading(false);
  }

  useEffect(() => { load(""); }, []);

  return (
    <div className="min-h-screen bg-slate-50 p-6">
      <div className="mx-auto max-w-6xl space-y-4">
        <div className="flex flex-col md:flex-row md:items-end gap-3 justify-between">
          <div>
            <h1 className="text-2xl font-semibold">Clients</h1>
            <p className="text-sm text-slate-600">Search by last name, first name, or SSN.</p>
          </div>

          <form onSubmit={(e)=>{e.preventDefault(); load(q);}} className="flex gap-2">
            <input
              value={q}
              onChange={(e) => setQ(e.target.value)}
              placeholder="Search…"
              className="h-10 w-72 rounded-xl border border-slate-200 bg-white px-3 text-sm"
            />
            <button
              type="submit"
              className="h-10 rounded-xl bg-emerald-600 px-4 text-sm font-semibold text-white"
            >
              Search
            </button>
          </form>
        </div>

        {error && (
          <div className="rounded-2xl bg-rose-50 p-4 text-sm text-rose-800 ring-1 ring-rose-200">
            {error}
          </div>
        )}

        <div className="rounded-2xl bg-white ring-1 ring-slate-200 overflow-hidden">
          <div className="border-b px-4 py-3 text-sm font-semibold">
            {loading ? "Loading…" : `${rows.length} results`}
          </div>

          <div className="divide-y">
            {rows.map((c) => (
              <Link
                key={c.SSN}
                href={`/clients/${encodeURIComponent(c.SSN)}`}
                className="block p-4 hover:bg-slate-50"
              >
                <div className="flex items-center justify-between">
                  <div className="min-w-0">
                    <div className="font-semibold text-slate-900 truncate">
                      {(c.LastName ?? "").toUpperCase()}, {c.FirstName ?? ""}
                    </div>
                    <div className="text-sm text-slate-600 truncate">
                      {c.Town ?? ""}{c.State ? `, ${c.State}` : ""} • {c.Phone ?? ""}
                    </div>
                  </div>
                  <div className="text-xs text-slate-500">SSN: ****{c.SSN?.slice(-4)}</div>
                </div>
              </Link>
            ))}

            {!loading && rows.length === 0 && (
              <div className="p-4 text-sm text-slate-600">No clients found.</div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
