import { withAuth } from "next-auth/middleware";
import type { NextRequest } from "next/server";
import { NextResponse } from "next/server";

/**
 * Best-effort per-IP rate limiting (single server).
 * If you scale later, move this to IIS/ARR/WAF.
 */
const buckets = new Map<string, { count: number; resetAt: number }>();

function rateLimit(req: NextRequest, keyPrefix: string, limit: number, windowMs: number) {
  const ip =
    req.ip ||
    req.headers.get("x-forwarded-for")?.split(",")[0]?.trim() ||
    "unknown";

  const key = `${keyPrefix}:${ip}`;
  const now = Date.now();
  const item = buckets.get(key);

  if (!item || now > item.resetAt) {
    buckets.set(key, { count: 1, resetAt: now + windowMs });
    return null;
  }

  item.count += 1;
  if (item.count > limit) {
    const retryAfter = Math.max(1, Math.ceil((item.resetAt - now) / 1000));
    return NextResponse.json(
      { error: "Too many requests. Please try again." },
      { status: 429, headers: { "Retry-After": String(retryAfter) } }
    );
  }

  return null;
}

export default withAuth(
  function middleware(req) {
    const pathname = req.nextUrl.pathname;

    // Rate limit sensitive endpoints
    if (pathname.startsWith("/api/auth")) {
      const blocked = rateLimit(req as unknown as NextRequest, "auth", 20, 60_000);
      if (blocked) return blocked;
    }
    if (pathname.startsWith("/api/admin")) {
      const blocked = rateLimit(req as unknown as NextRequest, "admin", 60, 60_000);
      if (blocked) return blocked;
    }

    // Admin gate
    const token = (req as any).nextauth?.token;
    if (pathname.startsWith("/admin")) {
      if (!token || token.role !== "admin") {
        const url = req.nextUrl.clone();
        url.pathname = "/unauthorized";
        return Response.redirect(url);
      }
    }
  },
  {
    callbacks: { authorized: ({ token }) => !!token },
    pages: { signIn: "/login" },
  }
);

export const config = {
  matcher: [
    "/clients/:path*",
    "/employees/:path*",
    "/adc-activities/:path*",
    "/admin/:path*",
    "/api/auth/:path*",
    "/api/admin/:path*",
  ],
};
