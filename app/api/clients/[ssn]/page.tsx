"use client";

import Link from "next/link";
import React, { useEffect, useState } from "react";

type Client = {
  SSN: string;
  FirstName: string | null;
  LastName: string | null;
  Phone: string | null;
  Home: string | null;
  Street: string | null;
  Apt: string | null;
  Town: string | null;
  State: string | null;
  Zip: string | null;
  DOB: string | null;
  Gender: string | null;
  ICD9: string | null;
  ICD10: string | null;
};

export default function ClientDetail({ params }: { params: { ssn: string } }) {
  const ssn = decodeURIComponent(params.ssn);
  const [client, setClient] = useState<Client | null>(null);
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);

  async function load() {
    const res = await fetch(`/api/clients/${encodeURIComponent(ssn)}`);
    const data = await res.json();
    setClient(data?.SSN ? data : null);
  }

  useEffect(() => { load(); }, [ssn]);

  async function save() {
    if (!client) return;
    setSaving(true);
    setMsg(null);

    const res = await fetch(`/api/clients/${encodeURIComponent(ssn)}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(client),
    });

    setSaving(false);
    setMsg(res.ok ? "Saved." : "Save failed.");
    if (res.ok) await load();
  }

  function set<K extends keyof Client>(key: K, value: Client[K]) {
    setClient((c) => (c ? { ...c, [key]: value } : c));
  }

  if (!client) {
    return (
      <div className="min-h-screen bg-slate-50 p-6">
        <div className="mx-auto max-w-3xl rounded-2xl bg-white p-6 ring-1 ring-slate-200">
          <div className="text-sm text-slate-600">Client not found.</div>
          <Link href="/clients" className="mt-3 inline-block text-sm font-semibold text-emerald-700">
            ← Back to Clients
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-slate-50 p-6">
      <div className="mx-auto max-w-5xl space-y-4">
        <div className="flex items-center justify-between">
          <div>
            <Link href="/clients" className="text-sm font-semibold text-slate-600 hover:text-slate-900">
              ← Clients
            </Link>
            <h1 className="mt-2 text-2xl font-semibold">
              {client.FirstName ?? ""} {client.LastName ?? ""}
            </h1>
            <div className="text-sm text-slate-600">SSN: ****{client.SSN.slice(-4)}</div>
          </div>

          <div className="flex items-center gap-2">
            {msg && <div className="text-sm text-slate-600">{msg}</div>}
            <button
              onClick={save}
              disabled={saving}
              className="h-10 rounded-xl bg-emerald-600 px-4 text-sm font-semibold text-white disabled:opacity-60"
            >
              {saving ? "Saving…" : "Save"}
            </button>
          </div>
        </div>

        <div className="grid gap-4 md:grid-cols-2">
          <Card title="Identity">
            <Field label="First Name" value={client.FirstName ?? ""} onChange={(v) => set("FirstName", v)} />
            <Field label="Last Name" value={client.LastName ?? ""} onChange={(v) => set("LastName", v)} />
            <Field label="Phone" value={client.Phone ?? ""} onChange={(v) => set("Phone", v)} />
            <Field label="Gender" value={client.Gender ?? ""} onChange={(v) => set("Gender", v)} />
            <Field label="DOB (YYYY-MM-DD)" value={(client.DOB ?? "").slice(0,10)} onChange={(v) => set("DOB", v || null)} />
          </Card>

          <Card title="Address">
            <Field label="Home" value={client.Home ?? ""} onChange={(v) => set("Home", v)} />
            <Field label="Street" value={client.Street ?? ""} onChange={(v) => set("Street", v)} />
            <Field label="Apt" value={client.Apt ?? ""} onChange={(v) => set("Apt", v)} />
            <Field label="Town" value={client.Town ?? ""} onChange={(v) => set("Town", v)} />
            <Field label="State" value={client.State ?? ""} onChange={(v) => set("State", v)} />
            <Field label="Zip" value={client.Zip ?? ""} onChange={(v) => set("Zip", v)} />
          </Card>

          <Card title="Clinical">
            <Field label="ICD9" value={client.ICD9 ?? ""} onChange={(v) => set("ICD9", v)} />
            <Field label="ICD10" value={client.ICD10 ?? ""} onChange={(v) => set("ICD10", v)} />
          </Card>
        </div>
      </div>
    </div>
  );
}

function Card({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="rounded-2xl bg-white p-4 ring-1 ring-slate-200">
      <div className="text-sm font-semibold text-slate-900">{title}</div>
      <div className="mt-3 grid gap-3">{children}</div>
    </div>
  );
}

function Field({ label, value, onChange }: { label: string; value: string; onChange: (v: string) => void }) {
  return (
    <div>
      <div className="text-xs font-medium text-slate-600">{label}</div>
      <input
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className="mt-1 h-10 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
      />
    </div>
  );
}
