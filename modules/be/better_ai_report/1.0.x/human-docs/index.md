# Better AI Report — manual setup guide

**Better AI Report** (`better_ai_report`) lets trusted staff describe a report in
plain English and get a table of data back — without writing any SQL and without
being able to change anything. A user types something like "list published
articles from last month with their authors"; the AI turns that into a structured
report specification, and the module runs it as a safe, read‑only query.

The point of the module is the safety boundary around that AI step. The AI never
touches the database directly. Whatever it proposes is checked by a deterministic
guard against per‑role allow/deny lists of which tables and columns each user is
even permitted to see, every value is parameterised, and the query is always
read‑only. If a prompt tries to reach data outside the user's allowed scope, the
guard simply rejects it — a cleverly worded or malicious prompt can never widen
access. Row caps, per‑user rate limiting, and an audit log of every report round
it out.

Results appear in a report builder screen where the user can preview them and
export to CSV. Three separate permissions keep the roles apart: one to configure
the module, one to generate reports, and one to bypass the row limit.

Because it uses AI, Better AI Report depends on the **AI** module (`ai`) and a
configured AI provider, and the data your queries touch is sent to that provider
to build the report spec — see [Installation](installation/index.md) and
[Configuration](configuration/index.md) for the provider and secret‑key setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its AI
   dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — choose the AI provider, set the
   per‑role allow/deny lists and row cap, and understand the permissions.

## Where it lives in the admin menu

- **Settings:** **Configuration → Better AI Report → Settings**
  (`/admin/config/better-ai-report/settings`) — needs the
  **Administer better AI report** permission.
- **Report builder:** **Reports → Better AI Report**
  (`/admin/reports/better-ai-report`) — needs the **Generate better AI reports**
  permission.
