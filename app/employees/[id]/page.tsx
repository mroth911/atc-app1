"use client";

import Link from "next/link";
import React, { useMemo, useState } from "react";

type Tab = "Address" | "Vacations" | "Narratives" | "Mileage" | "Rate Override";
type Gender = "M" | "F" | "X" | "";

type Employee = {
  id: string;
  payrollId: string;
  firstName: string;
  middleInitial: string;
  lastName: string;

  address: {
    home: string;
    street: string;
    apt: string;
    town: string;
    state: string;
    zip: string;
    homePhone: string;
    workPhone: string;
    cell: string;
  };

  email: string;
  reference: string;

  emergency: {
    name: string;
    phone: string;
    relationship: string;
  };

  languages: {
    primary: string;
    secondary: string;
  };

  maritalStatus: string;
  familyStatus: string;
  employmentType: "Full Time" | "Part Time";
  department: string;
  hours: number;

  gender: Gender;
  dob: string;
  hireDate: string;
  lastDate: string;
  position: string;
  positionEvv: string;
  status: "Active" | "Inactive";

  authEndDate: string;
  driverLicenseEnd: string;
  carRegEnd: string;
  carInsEnd: string;
  validDocEnd: string;
  validDocument: string;
  lastEvalDate: string;

  note: string;
  payrollNote: string;
  resignation: string;
  vax: string;
};

const towns = ["Newington", "Berlin", "Bristol", "Plainville", "Terryville", "Waterbury", "Wolcott"];
const langs = ["English", "Spanish", "Russian", "Polish", "Portuguese"];
const positions = ["PCA", "HM", "CP", "HMK, CP, PCA"];

function Card({
  title,
  children,
  right,
}: {
  title: string;
  children: React.ReactNode;
  right?: React.ReactNode;
}) {
  return (
    <div className="rounded-2xl bg-white ring-1 ring-slate-200">
      <div className="flex items-center justify-between border-b border-slate-100 px-4 py-3">
        <div className="text-sm font-semibold text-slate-900">{title}</div>
        {right}
      </div>
      <div className="p-4">{children}</div>
    </div>
  );
}

function Label({ children }: { children: React.ReactNode }) {
  return <div className="text-xs font-medium text-slate-600">{children}</div>;
}

function TextInput({
  value,
  onChange,
  type = "text",
  placeholder,
}: {
  value: string;
  onChange: (v: string) => void;
  type?: React.HTMLInputTypeAttribute;
  placeholder?: string;
}) {
  return (
    <input
      value={value}
      onChange={(e) => onChange(e.target.value)}
      type={type}
      placeholder={placeholder}
      className="h-10 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
    />
  );
}

function Select({
  value,
  onChange,
  options,
}: {
  value: string;
  onChange: (v: string) => void;
  options: string[];
}) {
  return (
    <select
      value={value}
      onChange={(e) => onChange(e.target.value)}
      className="h-10 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
    >
      {options.map((o) => (
        <option key={o} value={o}>
          {o}
        </option>
      ))}
    </select>
  );
}

function NumInput({ value, onChange }: { value: number; onChange: (n: number) => void }) {
  return (
    <input
      value={Number.isFinite(value) ? value : 0}
      onChange={(e) => onChange(Number(e.target.value || 0))}
      type="number"
      min={0}
      className="h-10 w-full rounded-xl border border-slate-200 bg-white px-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
    />
  );
}

export default function EmployeeDetailPage({ params }: { params: { id: string } }) {
  const [tab, setTab] = useState<Tab>("Address");

  const [emp, setEmp] = useState<Employee>({
    id: params.id,
    payrollId: "",
    firstName: "Aleksandr",
    middleInitial: "B",
    lastName: "Shevchenko",
    address: {
      home: "140",
      street: "Webster Court",
      apt: "",
      town: "Newington",
      state: "CT",
      zip: "06111",
      homePhone: "(860) 594-8883",
      workPhone: "",
      cell: "(860) 977-8906",
    },
    email: "mentpapa@mail.ru",
    reference: "",
    emergency: { name: "Wife", phone: "(860) 977-8905", relationship: "Spouse" },
    languages: { primary: "Russian", secondary: "Russian" },
    maritalStatus: "",
    familyStatus: "",
    employmentType: "Part Time",
    department: "PCA, HM, H",
    hours: 0,
    gender: "M",
    dob: "1959-07-25",
    hireDate: "2003-10-02",
    lastDate: "2999-01-01",
    position: "HMK, CP, PCA",
    positionEvv: "PCA",
    status: "Active",
    authEndDate: "",
    driverLicenseEnd: "2033-07-25",
    carRegEnd: "2027-07-12",
    carInsEnd: "2026-02-08",
    validDocEnd: "2026-06-16",
    validDocument: "Passport",
    lastEvalDate: "2019-12-30",
    note: "orig hire 10/2/03, inactive 12/30/20, rehired 9/7/21",
    payrollNote: "vac 5/5-6/1/24 ret 6/2/24, vac 10/13-11/16/24 ret 11/17/24",
    resignation: "",
    vax: "",
  });

  const fullName = useMemo(() => {
    const mi = emp.middleInitial ? ` ${emp.middleInitial}.` : "";
    return `${emp.lastName}, ${emp.firstName}${mi}`;
  }, [emp]);

  function set<K extends keyof Employee>(key: K, value: Employee[K]) {
    setEmp((p) => ({ ...p, [key]: value }));
  }

  return (
    <div className="min-h-screen bg-slate-50">
      <div className="sticky top-0 z-20 border-b border-slate-200 bg-white/80 backdrop-blur">
        <div className="mx-auto max-w-7xl px-4 py-4">
          <div className="flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
            <div className="min-w-0">
              <div className="flex items-center gap-3">
                <Link href="/employees" className="text-sm font-semibold text-slate-600 hover:text-slate-900">
                  ← Employees
                </Link>
                <span className="text-slate-300">/</span>
                <span className="text-sm font-semibold text-slate-900">Employee</span>
              </div>
              <h1 className="mt-2 truncate text-2xl font-semibold tracking-tight">{fullName}</h1>
              <p className="mt-1 text-sm text-slate-600">
                Employee ID: <span className="font-medium text-slate-900">#{emp.id}</span> • Status:{" "}
                <span className="font-medium text-slate-900">{emp.status}</span>
              </p>
            </div>

            <div className="flex flex-wrap gap-2">
              <button
                className="h-10 rounded-xl bg-emerald-600 px-4 text-sm font-semibold text-white hover:bg-emerald-700"
                type="button"
                onClick={() => alert("Save (wire to API later)")}
              >
                Save
              </button>
              <button
                className="h-10 rounded-xl bg-white px-4 text-sm font-semibold text-slate-900 ring-1 ring-slate-200 hover:bg-slate-50"
                type="button"
                onClick={() => alert("Report (placeholder)")}
              >
                Report
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
        </div>
      </div>

      <div className="mx-auto max-w-7xl px-4 py-6 space-y-4">
        <div className="grid gap-4 lg:grid-cols-[420px_1fr]">
          <Card title="Identity">
            <div className="grid gap-3">
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <Label>Employee ID</Label>
                  <TextInput value={emp.id} onChange={(v) => set("id", v)} />
                </div>
                <div>
                  <Label>Employee Payroll ID</Label>
                  <TextInput value={emp.payrollId} onChange={(v) => set("payrollId", v)} />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <Label>First Name</Label>
                  <TextInput value={emp.firstName} onChange={(v) => set("firstName", v)} />
                </div>
                <div>
                  <Label>Middle Initial</Label>
                  <TextInput value={emp.middleInitial} onChange={(v) => set("middleInitial", v)} />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <Label>Last Name</Label>
                  <TextInput value={emp.lastName} onChange={(v) => set("lastName", v)} />
                </div>
                <div>
                  <Label>E-mail</Label>
                  <TextInput value={emp.email} onChange={(v) => set("email", v)} type="email" />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <Label>Reference</Label>
                  <TextInput value={emp.reference} onChange={(v) => set("reference", v)} />
                </div>
                <div>
                  <Label>Department</Label>
                  <TextInput value={emp.department} onChange={(v) => set("department", v)} />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <Label>Employment</Label>
                  <Select value={emp.employmentType} onChange={(v) => set("employmentType", v as any)} options={["Full Time", "Part Time"]} />
                </div>
                <div>
                  <Label>Hours</Label>
                  <NumInput value={emp.hours} onChange={(n) => set("hours", n)} />
                </div>
              </div>

              <div className="grid grid-cols-3 gap-3">
                <div>
                  <Label>Gender</Label>
                  <Select
                    value={emp.gender || "—"}
                    onChange={(v) => set("gender", (v === "—" ? "" : (v as any)))}
                    options={["—", "M", "F", "X"]}
                  />
                </div>
                <div className="col-span-2">
                  <Label>DOB</Label>
                  <TextInput value={emp.dob} onChange={(v) => set("dob", v)} type="date" />
                </div>
              </div>

              <div className="grid grid-cols-3 gap-3">
                <div>
                  <Label>Hire Date</Label>
                  <TextInput value={emp.hireDate} onChange={(v) => set("hireDate", v)} type="date" />
                </div>
                <div>
                  <Label>Last Date</Label>
                  <TextInput value={emp.lastDate} onChange={(v) => set("lastDate", v)} type="date" />
                </div>
                <div>
                  <Label>Status</Label>
                  <Select value={emp.status} onChange={(v) => set("status", v as any)} options={["Active", "Inactive"]} />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <Label>Position</Label>
                  <Select value={emp.position} onChange={(v) => set("position", v)} options={positions} />
                </div>
                <div>
                  <Label>Position EVV</Label>
                  <Select value={emp.positionEvv} onChange={(v) => set("positionEvv", v)} options={["PCA", "HM", "CP"]} />
                </div>
              </div>
            </div>
          </Card>

          <div className="space-y-4">
            <Card title="Emergency & Languages">
              <div className="grid gap-4 md:grid-cols-2">
                <div className="grid gap-3">
                  <div className="text-sm font-semibold text-slate-900">Emergency Contact</div>
                  <div>
                    <Label>Name</Label>
                    <TextInput value={emp.emergency.name} onChange={(v) => set("emergency", { ...emp.emergency, name: v })} />
                  </div>
                  <div>
                    <Label>Phone</Label>
                    <TextInput value={emp.emergency.phone} onChange={(v) => set("emergency", { ...emp.emergency, phone: v })} />
                  </div>
                  <div>
                    <Label>Relationship</Label>
                    <TextInput value={emp.emergency.relationship} onChange={(v) => set("emergency", { ...emp.emergency, relationship: v })} />
                  </div>
                </div>

                <div className="grid gap-3">
                  <div className="text-sm font-semibold text-slate-900">Languages</div>
                  <div>
                    <Label>Primary</Label>
                    <Select value={emp.languages.primary} onChange={(v) => set("languages", { ...emp.languages, primary: v })} options={langs} />
                  </div>
                  <div>
                    <Label>Secondary</Label>
                    <Select value={emp.languages.secondary} onChange={(v) => set("languages", { ...emp.languages, secondary: v })} options={langs} />
                  </div>
                  <div className="grid grid-cols-2 gap-3">
                    <div>
                      <Label>Marital Status</Label>
                      <TextInput value={emp.maritalStatus} onChange={(v) => set("maritalStatus", v)} />
                    </div>
                    <div>
                      <Label>Family Status</Label>
                      <TextInput value={emp.familyStatus} onChange={(v) => set("familyStatus", v)} />
                    </div>
                  </div>
                </div>
              </div>
            </Card>

            <Card title="Compliance / Expirations">
              <div className="grid gap-3 md:grid-cols-3">
                <div>
                  <Label>Employment Auth End</Label>
                  <TextInput value={emp.authEndDate} onChange={(v) => set("authEndDate", v)} type="date" />
                </div>
                <div>
                  <Label>Driver License End</Label>
                  <TextInput value={emp.driverLicenseEnd} onChange={(v) => set("driverLicenseEnd", v)} type="date" />
                </div>
                <div>
                  <Label>Car Reg End</Label>
                  <TextInput value={emp.carRegEnd} onChange={(v) => set("carRegEnd", v)} type="date" />
                </div>
                <div>
                  <Label>Car Insurance End</Label>
                  <TextInput value={emp.carInsEnd} onChange={(v) => set("carInsEnd", v)} type="date" />
                </div>
                <div>
                  <Label>Valid Document</Label>
                  <TextInput value={emp.validDocument} onChange={(v) => set("validDocument", v)} />
                </div>
                <div>
                  <Label>Valid Doc End</Label>
                  <TextInput value={emp.validDocEnd} onChange={(v) => set("validDocEnd", v)} type="date" />
                </div>
                <div>
                  <Label>Last Evaluation Date</Label>
                  <TextInput value={emp.lastEvalDate} onChange={(v) => set("lastEvalDate", v)} type="date" />
                </div>
              </div>
            </Card>
          </div>
        </div>

        <div className="rounded-2xl bg-white ring-1 ring-slate-200">
          <div className="flex flex-wrap gap-2 border-b border-slate-100 px-4 py-3">
            {(["Address", "Vacations", "Narratives", "Mileage", "Rate Override"] as Tab[]).map((t) => {
              const active = t === tab;
              return (
                <button
                  key={t}
                  type="button"
                  onClick={() => setTab(t)}
                  className={
                    active
                      ? "h-9 rounded-xl bg-emerald-600 px-3 text-sm font-semibold text-white"
                      : "h-9 rounded-xl bg-white px-3 text-sm font-semibold text-slate-700 ring-1 ring-slate-200 hover:bg-slate-50"
                  }
                >
                  {t}
                </button>
              );
            })}
          </div>

          <div className="p-4">
            {tab === "Address" ? (
              <div className="grid gap-4 lg:grid-cols-2">
                <Card title="Address">
                  <div className="grid gap-3">
                    <div className="grid grid-cols-3 gap-3">
                      <div>
                        <Label>Home</Label>
                        <TextInput value={emp.address.home} onChange={(v) => set("address", { ...emp.address, home: v })} />
                      </div>
                      <div className="col-span-2">
                        <Label>Street</Label>
                        <TextInput value={emp.address.street} onChange={(v) => set("address", { ...emp.address, street: v })} />
                      </div>
                    </div>

                    <div>
                      <Label>Apt</Label>
                      <TextInput value={emp.address.apt} onChange={(v) => set("address", { ...emp.address, apt: v })} />
                    </div>

                    <div className="grid grid-cols-3 gap-3">
                      <div className="col-span-2">
                        <Label>Town</Label>
                        <Select value={emp.address.town} onChange={(v) => set("address", { ...emp.address, town: v })} options={towns} />
                      </div>
                      <div>
                        <Label>State</Label>
                        <TextInput value={emp.address.state} onChange={(v) => set("address", { ...emp.address, state: v })} />
                      </div>
                    </div>

                    <div className="grid grid-cols-2 gap-3">
                      <div>
                        <Label>Zip Code</Label>
                        <TextInput value={emp.address.zip} onChange={(v) => set("address", { ...emp.address, zip: v })} />
                      </div>
                      <div>
                        <Label>Home Phone</Label>
                        <TextInput value={emp.address.homePhone} onChange={(v) => set("address", { ...emp.address, homePhone: v })} />
                      </div>
                    </div>

                    <div className="grid grid-cols-2 gap-3">
                      <div>
                        <Label>Work Phone</Label>
                        <TextInput value={emp.address.workPhone} onChange={(v) => set("address", { ...emp.address, workPhone: v })} />
                      </div>
                      <div>
                        <Label>Cell</Label>
                        <TextInput value={emp.address.cell} onChange={(v) => set("address", { ...emp.address, cell: v })} />
                      </div>
                    </div>
                  </div>
                </Card>

                <Card title="Notes">
                  <div className="grid gap-3">
                    <div>
                      <Label>Note</Label>
                      <textarea
                        value={emp.note}
                        onChange={(e) => set("note", e.target.value)}
                        className="min-h-28 w-full rounded-2xl border border-slate-200 bg-white p-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
                        placeholder="General notes…"
                      />
                    </div>
                    <div>
                      <Label>Payroll Note</Label>
                      <textarea
                        value={emp.payrollNote}
                        onChange={(e) => set("payrollNote", e.target.value)}
                        className="min-h-28 w-full rounded-2xl border border-slate-200 bg-white p-3 text-sm outline-none focus:border-emerald-400 focus:ring-2 focus:ring-emerald-200"
                        placeholder="Payroll notes…"
                      />
                    </div>
                  </div>
                </Card>
              </div>
            ) : (
              <div className="rounded-2xl bg-slate-50 p-4 ring-1 ring-slate-200">
                <div className="text-sm font-semibold text-slate-900">{tab}</div>
                <p className="mt-2 text-sm text-slate-600">Placeholder. We’ll build the {tab} grid/list next.</p>
              </div>
            )}
          </div>
        </div>

        <div className="flex justify-end gap-2">
          <button
            className="h-10 rounded-xl bg-white px-4 text-sm font-semibold text-slate-900 ring-1 ring-slate-200 hover:bg-slate-50"
            type="button"
            onClick={() => alert("Schedule - Calendar (placeholder)")}
          >
            Schedule - Calendar
          </button>
        </div>
      </div>
    </div>
  );
}
