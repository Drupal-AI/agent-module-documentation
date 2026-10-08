# Configuration

Everything happens from the dashboard at **Reports → EqualWeb PDF Accessibility**
(`/admin/reports/equalweb-pdf`). There is no separate settings screen to fill in
before you begin — free checks work immediately — but a few steps make the module
production-ready.

## Set permissions

The module ships granular permissions so you can hand out exactly what each role
needs. Set them at **People → Permissions**:

- **Administer EqualWeb PDF** — full control: settings, site registration,
  classification, and it sees every file. Give this to site administrators only.
- **View any EqualWeb PDF files** — see all files on the dashboard.
- **View own EqualWeb PDF files** — see only files the user owns.
- **Check EqualWeb PDF files** — run the free accessibility check.
- **Remediate EqualWeb PDF files** — run AI remediation (spends credits).
- **Replace EqualWeb PDF files** — apply a remediated file in place or restore the
  original from backup.

The dashboard scopes what each user sees to the files their permissions allow, so a
"view own" user only ever works with their own uploads.

## Register the site (for remediation)

The free check needs nothing. For remediation, open the dashboard and use the
**registration** action to connect the site to a free EqualWeb account. If you want
to lift the rate limit on keyless checks, add a **free EqualWeb API key** through
the same settings — the key is stored and used server-side and is never exposed to
the browser. You can also check the remaining **credit balance** from the
dashboard.

## Run checks and remediation

From the dashboard:

1. **Check** a file to get its PDF/UA score and a rule-by-rule report. Checks can
   run in the background; the dashboard polls a running check to completion.
2. **Remediate** an inaccessible file (uses credits). Remediation tags the
   document, fixes reading order, heading levels, tables, lists, links and
   references, runs OCR on scanned pages, and writes real alternate text for
   images — while keeping the document's layout and visual design unchanged.
3. Choose whether to **replace** the original in place (a restorable backup is
   kept) or **save a new accessible copy** as a separate file. If you replace, you
   can **restore** the original from backup later.
4. **Download** the remediated file via the dashboard's protected download link.

## Reports and file management (admin)

- **Before/after scores** and downloadable reports are available per file, and a
  yearly executive **compliance report** summarises accessibility across the site.
- **Classification/tagging** (admin) lets you tag or bulk-tag files to change
  remediation priority, and set archive-year thresholds.
- **Ignore** files you don't want to track — an admin action that hides a file from
  every viewer; it is reversible and logged.
