import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import bcrypt from "bcryptjs";
import { prisma } from "@/lib/prisma";
import { authOptions } from "@/app/api/auth/[...nextauth]/route";

export async function PATCH(req: Request, { params }: { params: { id: string } }) {
  const session = await getServerSession(authOptions);
  if ((session as any)?.role !== "admin") {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const body = await req.json();
  const data: any = {};

  if (body.role) data.role = body.role;
  if (body.password) data.passwordHash = await bcrypt.hash(body.password, 12);
  if (body.name) data.name = body.name;

  const user = await prisma.user.update({
    where: { id: params.id },
    data,
  });

  return NextResponse.json(user);
}
