# HomeMaker Web (Next.js)

This is a starter Next.js (App Router) + Tailwind project that modernizes your MS Access Switchboard + Client screen.

## Run locally
1. Install Node.js 18+ (recommended).
2. In this folder:

```bash
npm install
npm run dev
```

Then open http://localhost:3000

## Routes
- `/` Switchboard
- `/clients` Client profile screen (modernized)
- `/employees` Employees selector (modernized)
- `/employees/[id]` Employee detail (modernized)
- `/adc-activities` Adult Daycare Activities (modernized)
- Other routes are placeholders (hm-activities, invoices, payments, catalogs)

## Next steps
- Add a Clients list page (search/filter) and load/save via API routes
- Connect to your SQL DB (SQL Server/Postgres/MySQL) and map tables

## Authentication + Admin
This project includes NextAuth (Credentials provider) + Prisma models for SQL Server.
- Login page: `/login`
- Admin panel: `/admin` (requires role = `admin`)

### Setup steps
1) Copy `.env.example` to `.env.local` and set:
- `DATABASE_URL`
- `NEXTAUTH_SECRET`

2) Run Prisma + create an admin user:
```bash
npm install
npm run prisma:migrate
npm run prisma:seed
npm run dev
```

Then sign in at `/login` with the seeded admin credentials.

> Note: The UI pages like `/clients`, `/employees`, `/adc-activities` are protected by middleware and require login.
