import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

async function findClient(ssn: string) {
  const c1 = await prisma.client.findUnique({ where: { SSN: ssn } });
  if (c1) return { data: c1, source: "Client" };

  const c2 = await prisma.client2.findUnique({ where: { SSN: ssn } });
  if (c2) return { data: c2, source: "Client2" };

  return null;
}

export async function GET(_: Request, { params }: { params: { ssn: string } }) {
  const found = await findClient(params.ssn);
  if (!found) {
    return NextResponse.json({ error: "Not found" }, { status: 404 });
  }
  return NextResponse.json({ ...found.data, _source: found.source });
}

export async function PUT(req: Request, { params }: { params: { ssn: string } }) {
  const body = await req.json();
  const data = {
    FirstName: body.FirstName ?? null,
    LastName: body.LastName ?? null,
    Phone: body.Phone ?? null,
    Home: body.Home ?? null,
    Street: body.Street ?? null,
    Apt: body.Apt ?? null,
    Town: body.Town ?? null,
    State: body.State ?? null,
    Zip: body.Zip ?? null,
    Gender: body.Gender ?? null,
    DOB: body.DOB ? new Date(body.DOB) : null,
  };

  if (body._source === "Client2") {
    const updated = await prisma.client2.update({
      where: { SSN: params.ssn },
      data,
    });
    return NextResponse.json({ ...updated, _source: "Client2" });
  }

  const updated = await prisma.client.update({
    where: { SSN: params.ssn },
    data,
  });
  return NextResponse.json({ ...updated, _source: "Client" });
}
