# Configuration

Better AI Report has two screens: a **settings** form where an administrator
defines what may be reported and which AI provider to use, and a **report
builder** where authorised users actually generate reports.

## Open the settings form

1. Log in as a user with the **Administer better AI report** permission.
2. Go to **Configuration → Better AI Report → Settings**, or navigate directly to
   `/admin/config/better-ai-report/settings`.

On this form you configure:

- **AI provider** — which of the AI module's configured providers is used to turn
  a natural‑language request into a report specification.
- **Per‑role allow / deny lists** — the entities and tables (and their columns)
  that each role is permitted to report on. This is the heart of the security
  model: the AI is only ever shown the allow‑listed schema, and the guard rejects
  any generated spec that references a table or column outside the acting user's
  scope. Keep these lists tight — a role can never report on data you have not
  allow‑listed.
- **Row‑scope filters** — optionally restrict reports to the current user's own
  rows.
- **Maximum row cap** — the largest number of rows a report may return. Users with
  the bypass permission (below) can exceed it.

## The report builder

Users with the **Generate better AI reports** permission open **Reports → Better
AI Report** (`/admin/reports/better-ai-report`), describe the report they want in
plain language, refine it through a short back‑and‑forth if needed, preview the
result, and export it to CSV. The CSV export is CSRF‑protected. All queries are
read‑only and parameterised, so nothing on this screen can modify data.

## Permissions

Three permissions keep the roles separate — all are sensitive, so grant them
deliberately:

| Permission | Who should have it | What it allows |
|------------|--------------------|----------------|
| **Administer better AI report** | Site administrators | Change the provider, allow/deny lists, row‑scope filters, and row cap. |
| **Generate better AI reports** | Trusted analysts | Run reports across the allow‑listed data and export CSV. This is a broad read of everything you have allow‑listed. |
| **Bypass better AI report row limit** | Power users | Exceed the configured maximum row cap. |

## A note on what is sent to the AI

To build a report spec, the module sends the request and the allow‑listed schema
context to your configured AI provider. It does not send data outside the
allow‑listed scope, but be aware that report‑generation prompts do leave your site
for the provider — factor that into your data‑handling and privacy decisions, and
keep the allow lists limited to what analysts genuinely need.
