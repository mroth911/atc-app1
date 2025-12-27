import Link from "next/link";

export default function UnauthorizedPage() {
  return (
    <div className="min-h-screen bg-slate-50 grid place-items-center p-6">
      <div className="w-full max-w-lg rounded-3xl bg-white p-6 ring-1 ring-slate-200">
        <h1 className="text-2xl font-semibold tracking-tight text-slate-900">Unauthorized</h1>
        <p className="mt-2 text-sm text-slate-600">
          You are signed in, but you don’t have permission to access this page.
        </p>
        <div className="mt-6 flex gap-2">
          <Link
            href="/"
            className="h-10 inline-flex items-center rounded-xl bg-white px-4 text-sm font-semibold text-slate-900 ring-1 ring-slate-200 hover:bg-slate-50"
          >
            Back to Switchboard
          </Link>
          <Link
            href="/login"
            className="h-10 inline-flex items-center rounded-xl bg-emerald-600 px-4 text-sm font-semibold text-white hover:bg-emerald-700"
          >
            Sign in again
          </Link>
        </div>
      </div>
    </div>
  );
}
