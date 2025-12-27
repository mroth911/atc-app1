import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

function ssnOf(row: any) {
  return row.SSN ?? row.ssn ?? row.Ssn;
}

export async function GET(req: Request) {
  try {
    const url = new URL(req.url);
    const q = url.searchParams.get("q")?.trim();

    const where = q
      ? {
          OR: [
            { FirstName: { contains: q } },
            { LastName: { contains: q } },
            { SSN: { contains: q } },
          ],
        }
      : undefined;

    const [primary, secondary] = await Promise.all([
      prisma.client.findMany({ where, take: 100 }),
      prisma.client2.findMany({ where, take: 100 }),
    ]);

    // Merge + dedupe by SSN (Client wins)
    const map = new Map<string, any>();

    for (const r of secondary) {
      const ssn = ssnOf(r);
      if (ssn) map.set(ssn, { ...r, _source: "Client2" });
    }

    for (const r of primary) {
      const ssn = ssnOf(r);
      if (ssn) map.set(ssn, { ...r, _source: "Client" });
    }

    return NextResponse.json(Array.from(map.values()));
  } catch (e: any) {
    return NextResponse.json(
      { error: "API failed", details: e.message },
      { status: 500 }
    );
  }
}
