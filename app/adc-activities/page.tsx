"use client";

import Link from "next/link";
import React, { useMemo, useState } from "react";

type ClientOpt = { id: string; name: string };

const clients: ClientOpt[] = [
  { id: "1", name: "Ruth Abair" },
  { id: "2", name: "John Smith" },
  { id: "3", name: "Mary Johnson" },
];

function Card({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="rounded-2xl bg-white ring-1 ring-slate-200">
      <div className="border-b border-slate-100 px-4 py-3 text-sm font-semibold text-slate-900">{title}</div>
      <div className="p-4">{children}</div>
    </div>
  );
}

function Label({ children }: { children: React.ReactNode }) {
  return <div className="text-xs font-medium text-slate-600">{children}</div>;
}

function dateInfo(dateStr: string) {
  const d = new Date(dateStr + "T00:00:00");
  if (Number.isNaN(d.getTime())) return { dow: "—", week: "—" };
  const dow = d.toLocaleDateString(undefined, { weekday: "long" });
  const tmp = new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()));
  const dayNum = tmp.getUTCDay() || 7;
  tmp.setUTCDate(tmp.getUTCDate() + 4 - dayNum);
  const yearStart = new Date(Date.UTC(tmp.getUTCFullYear(), 0, 1));
  const week = Math.ceil((((tmp.getTime() - yearStart.getTime()) / 86400000) + 1) / 7);
  return { dow, week: String(week) };
}

export default function AdcActivitiesPage() {
  const today = new Date();
  const yyyy = today.getFullYear();
  const mm = String(today.getMonth() + 1).padStart(2, "0");
  const dd = String(today.getDate()).padStart(2, "0");

  const [from, setFrom] = useState(`${yyyy}-${mm}-${dd}`);
  const [to, setTo] = useState(`${yyyy}-${mm}-${dd}`);
  const [clientMode, setClientMode] = useState<"all" | "one">("all");
  const [clientId, setClientId] = useState("1");

  const fromInfo = useMemo(() => dateInfo(from), [from]);
  const toInfo = useMemo(() => dateInfo(to), [to]);

  const selectedClientName = useMemo(() => {
    if (clientMode === "all") return "All Clients";
    return clients.find((c) => c.id === clientId)?.name ?? "—";
  }, [clientMode, clientId]);

  function action(name: string) {
    alert(`${name} (placeholder)\n\nFrom: ${from}\nTo: ${to}\nClient: ${selectedClientName}`);
  }

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
                <span className="text-sm font-semibold text-slate-900">Adult Daycare Activities</span>
              </div>
              <h1 className="mt-2 text-2xl font-semibold tracking-tight">Adult Daycare Activities</h1>
              <p className="mt-1 text-sm text-slate-600">Select date range and run weekly/monthly actions (modernized from Access).</p>
            </div>

            <button
              className="h-10 rounded-xl bg-rose-600 px-4 text-sm font-semibold text-white hover:bg-rose-700"
              type="button"
              onClick={() => alert("Exit (placeholder)")}
            >
              Exit
            </button>
          </div>
        </div>
      </div>

      <div className="mx-auto max-w-7xl px-4 py-6 space-y-4">
        <div className="grid gap-4 lg:grid-cols-2">
          <Card title="From">
            <div className="grid gap-3">
              <div>
                <Label>Date</Label>
                <input
                  value={from}
                  onChange={(e) => setFrom(e.target.value)}
                  type="date"
                  className="h-11 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
                />
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div className="rounded-xl bg-slate-50 p-3 ring-1 ring-slate-200">
                  <div className="text-xs font-medium text-slate-600">Day</div>
                  <div className="mt-1 text-sm font-semibold text-slate-900">{fromInfo.dow}</div>
                </div>
                <div className="rounded-xl bg-slate-50 p-3 ring-1 ring-slate-200">
                  <div className="text-xs font-medium text-slate-600">Week Number</div>
                  <div className="mt-1 text-sm font-semibold text-slate-900">{fromInfo.week}</div>
                </div>
              </div>
            </div>
          </Card>

          <Card title="To">
            <div className="grid gap-3">
              <div>
                <Label>Date</Label>
                <input
                  value={to}
                  onChange={(e) => setTo(e.target.value)}
                  type="date"
                  className="h-11 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
                />
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div className="rounded-xl bg-slate-50 p-3 ring-1 ring-slate-200">
                  <div className="text-xs font-medium text-slate-600">Day</div>
                  <div className="mt-1 text-sm font-semibold text-slate-900">{toInfo.dow}</div>
                </div>
                <div className="rounded-xl bg-slate-50 p-3 ring-1 ring-slate-200">
                  <div className="text-xs font-medium text-slate-600">Week Number</div>
                  <div className="mt-1 text-sm font-semibold text-slate-900">{toInfo.week}</div>
                </div>
              </div>
            </div>
          </Card>
        </div>

        <Card title="Select Clients">
          <div className="grid gap-4 md:grid-cols-[260px_1fr] items-start">
            <div className="rounded-2xl bg-slate-50 p-4 ring-1 ring-slate-200">
              <div className="flex items-center gap-2">
                <input id="all" type="radio" checked={clientMode === "all"} onChange={() => setClientMode("all")} />
                <label htmlFor="all" className="text-sm font-semibold text-slate-900">
                  All Clients
                </label>
              </div>
              <div className="mt-3 flex items-center gap-2">
                <input id="one" type="radio" checked={clientMode === "one"} onChange={() => setClientMode("one")} />
                <label htmlFor="one" className="text-sm font-semibold text-slate-900">
                  One Client
                </label>
              </div>
            </div>

            <div className="rounded-2xl bg-white p-4 ring-1 ring-slate-200">
              <Label>Client</Label>
              <select
                value={clientId}
                onChange={(e) => setClientId(e.target.value)}
                disabled={clientMode !== "one"}
                className="mt-2 h-11 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200 disabled:bg-slate-50"
              >
                {clients.map((c) => (
                  <option key={c.id} value={c.id}>
                    {c.name}
                  </option>
                ))}
              </select>
              <p className="mt-2 text-sm text-slate-600">
                Selected: <span className="font-semibold text-slate-900">{selectedClientName}</span>
              </p>
            </div>
          </div>
        </Card>

        <div className="grid gap-3 md:grid-cols-4">
          <Action label="Open Week" onClick={() => action("Open Week")} />
          <Action label="View/Edit Week" onClick={() => action("View/Edit Week")} />
          <Action label="Close Week" onClick={() => action("Close Week")} />
          <Action label="Attendance List" onClick={() => action("Attendance List")} />
          <Action label="Billing Report" onClick={() => action("Billing Report")} />
          <Action label="View/Edit Month" onClick={() => action("View/Edit Month")} />
          <Action label="Employee Time Sheet" onClick={() => action("Employee Time Sheet")} />
          <Action label="ADC-MOW Cross Ref" onClick={() => action("ADC-MOW Cross Ref")} />
          <Action label="Billing Summary" onClick={() => action("Billing Summary")} />
          <Action label="Electronic Bill" onClick={() => action("Electronic Bill")} />
          <Action label="ADC-HM Cross Ref" onClick={() => action("ADC-HM Cross Ref")} />
        </div>
      </div>
    </div>
  );
}

function Action({ label, onClick }: { label: string; onClick: () => void }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="h-12 rounded-2xl bg-white px-4 text-sm font-semibold text-slate-900 ring-1 ring-slate-200 hover:bg-slate-50 transition"
    >
      {label}
    </button>
  );
}
