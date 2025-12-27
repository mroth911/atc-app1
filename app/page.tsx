"use client";

import Link from "next/link";

type Tile = {
  title: string;
  desc: string;
  href: string;
  tone: "sky" | "violet" | "emerald" | "amber" | "fuchsia" | "rose" | "indigo";
  icon: React.ReactNode;
};

function toneClasses(tone: Tile["tone"]) {
  switch (tone) {
    case "sky":
      return "bg-sky-500/10 text-sky-700 ring-sky-200";
    case "violet":
      return "bg-violet-500/10 text-violet-700 ring-violet-200";
    case "emerald":
      return "bg-emerald-500/10 text-emerald-700 ring-emerald-200";
    case "amber":
      return "bg-amber-500/10 text-amber-700 ring-amber-200";
    case "fuchsia":
      return "bg-fuchsia-500/10 text-fuchsia-700 ring-fuchsia-200";
    case "rose":
      return "bg-rose-500/10 text-rose-700 ring-rose-200";
    case "indigo":
      return "bg-indigo-500/10 text-indigo-700 ring-indigo-200";
  }
}

export default function Home() {
  const tiles: Tile[] = [
    {
      title: "Clients",
      desc: "Manage client profiles, addresses, contacts.",
      href: "/clients",
      tone: "sky",
      icon: (
        <svg className="h-5 w-5" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M16 11a4 4 0 1 0-8 0 4 4 0 0 0 8 0Z" stroke="currentColor" strokeWidth="2" />
          <path d="M4 20c1.5-3 4.2-5 8-5s6.5 2 8 5" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        </svg>
      ),
    },
    {
      title: "Employees",
      desc: "Staff records, roles, credentials.",
      href: "/employees",
      tone: "violet",
      icon: (
        <svg className="h-5 w-5" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M7 7h10v10H7V7Z" stroke="currentColor" strokeWidth="2" />
          <path d="M9 10h6M9 13h6" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        </svg>
      ),
    },
    {
      title: "HM Activities",
      desc: "HomeMaker visits, tasks, notes.",
      href: "/hm-activities",
      tone: "emerald",
      icon: (
        <svg className="h-5 w-5" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M9 6h6M9 10h6M9 14h6" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
          <path d="M8 4h8a2 2 0 0 1 2 2v14H6V6a2 2 0 0 1 2-2Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
        </svg>
      ),
    },
    {
      title: "ADC Activities",
      desc: "Adult day center activity tracking.",
      href: "/adc-activities",
      tone: "amber",
      icon: (
        <svg className="h-5 w-5" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M4 12h4l2-6 4 12 2-6h4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      ),
    },
    {
      title: "Invoices",
      desc: "Create, review, and export invoices.",
      href: "/invoices",
      tone: "fuchsia",
      icon: (
        <svg className="h-5 w-5" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M7 4h10v16l-2-1-2 1-2-1-2 1-2-1-2 1V4Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
          <path d="M9 9h6M9 12h6" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        </svg>
      ),
    },
    {
      title: "Payments",
      desc: "Track payments, balances, receipts.",
      href: "/payments",
      tone: "rose",
      icon: (
        <svg className="h-5 w-5" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M3 8h18v10H3V8Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
          <path d="M3 10h18" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
          <path d="M7 15h4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        </svg>
      ),
    },
    {
      title: "Catalogs",
      desc: "Service codes, rate tables, items.",
      href: "/catalogs",
      tone: "indigo",
      icon: (
        <svg className="h-5 w-5" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M4 4h7v7H4V4Zm9 0h7v7h-7V4ZM4 13h7v7H4v-7Zm9 0h7v7h-7v-7Z" stroke="currentColor" strokeWidth="2" />
        </svg>
      ),
    },
  ];

  return (
    <div className="min-h-screen bg-slate-50 text-slate-900">
      <div className="min-h-screen grid lg:grid-cols-[320px_1fr]">
        <aside className="bg-slate-900 text-white p-6 lg:p-8">
          <div className="flex items-center gap-3">
            <div className="h-11 w-11 rounded-2xl bg-emerald-500/20 ring-1 ring-emerald-400/30 grid place-items-center">
              <span className="text-xl font-semibold tracking-tight text-emerald-200">HM</span>
            </div>
            <div>
              <div className="text-lg font-semibold leading-tight">HomeMaker</div>
              <div className="text-sm text-slate-300">Switchboard</div>
            </div>
          </div>

          <div className="mt-8 rounded-2xl bg-white/5 ring-1 ring-white/10 p-4">
            <div className="text-sm text-slate-200 font-medium">Quick tips</div>
            <p className="mt-2 text-sm text-slate-300">
              Choose a module to manage data. This menu becomes your main navigation.
            </p>
          </div>

          <div className="mt-8 space-y-2 text-sm text-slate-300">
            <div className="flex items-center justify-between">
              <span>Status</span>
              <span className="inline-flex items-center gap-2">
                <span className="h-2 w-2 rounded-full bg-emerald-400" />
                Online
              </span>
            </div>
            <div className="flex items-center justify-between">
              <span>Environment</span>
              <span className="text-slate-200">Local</span>
            </div>
          </div>
        </aside>

        <main className="p-6 lg:p-10">
          <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
            <div>
              <h1 className="text-2xl font-semibold tracking-tight">Dashboard</h1>
              <p className="mt-1 text-slate-600">Welcome back. Pick a section to get started.</p>
            </div>

            <div className="flex gap-3">
              <button
                className="inline-flex items-center gap-2 rounded-xl bg-white px-4 py-2 text-sm font-medium ring-1 ring-slate-200 hover:bg-slate-50"
                type="button"
                onClick={() => alert("Settings (placeholder)")}
              >
                Settings
              </button>

              <button
                className="inline-flex items-center gap-2 rounded-xl bg-emerald-600 px-4 py-2 text-sm font-semibold text-white hover:bg-emerald-700"
                type="button"
                onClick={() => alert("New (placeholder)")}
              >
                New
              </button>
            </div>
          </div>

          <section className="mt-8 grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
            {tiles.map((t) => (
              <Link
                key={t.href}
                href={t.href}
                className="group w-full text-left bg-white rounded-2xl p-5 ring-1 ring-slate-200 hover:bg-slate-50 transition flex items-center gap-4"
              >
                <div className={`h-11 w-11 rounded-2xl ring-1 grid place-items-center shrink-0 ${toneClasses(t.tone)}`}>
                  {t.icon}
                </div>
                <div className="min-w-0">
                  <div className="text-base font-semibold tracking-tight">{t.title}</div>
                  <div className="mt-1 text-sm text-slate-600">{t.desc}</div>
                </div>
                <div className="ml-auto text-slate-400 text-lg group-hover:translate-x-0.5 transition">→</div>
              </Link>
            ))}

            <button
              className="w-full text-left bg-white rounded-2xl p-5 ring-1 ring-rose-200 hover:bg-rose-50 transition flex items-center gap-4"
              type="button"
              onClick={() => alert("Signed out (placeholder).")}
            >
              <div className="h-11 w-11 rounded-2xl ring-1 grid place-items-center shrink-0 bg-rose-500/10 text-rose-700 ring-rose-200">
                <svg className="h-5 w-5" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                  <path d="M10 7V5a2 2 0 0 1 2-2h7v18h-7a2 2 0 0 1-2-2v-2" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                  <path d="M3 12h10M7 8l-4 4 4 4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                </svg>
              </div>
              <div className="min-w-0">
                <div className="text-base font-semibold tracking-tight text-rose-700">Exit</div>
                <div className="mt-1 text-sm text-slate-600">Sign out and close this session.</div>
              </div>
              <div className="ml-auto text-rose-700 text-lg">→</div>
            </button>
          </section>

          <footer className="mt-10 text-sm text-slate-500">© {new Date().getFullYear()} HomeMaker • Web</footer>
        </main>
      </div>
    </div>
  );
}
