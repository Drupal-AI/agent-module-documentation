# AI Budget Control — manual setup guide

**AI Budget Control** (`ai_budget_control`) is a governance layer that meters and
caps the AI usage running through Drupal's [AI](https://www.drupal.org/project/ai)
module. It lets you set limits on how many tokens are spent, how much money is
spent (estimated from a price‑per‑1,000‑tokens figure), or how many requests are
made — and you can scope each limit to the whole site, to a role, or to an
individual user, per provider or across all providers at once.

It works automatically. Whenever any code on your site asks the AI module to
generate a response, this module checks it against your limits *before* the
provider is called. If a **hard** limit is exceeded, the request is stopped and a
message is returned instead of billing the API. A **soft** limit (for example a
warning at 80%) lets the request through but records a warning, so you get an
early heads‑up before a ceiling is hit. Every completed operation is logged with
its token counts and estimated cost.

Two admin surfaces come with it: a place to create and manage limits, and a
usage dashboard (with a CSV export) so you can watch consumption and estimated
spend per provider and per user. The module makes **no** outbound calls of its own
and never stores or logs your provider API keys — it only records metadata like
provider id, model, user, tokens, and estimated cost.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create usage limits field by field,
   and read the usage dashboard and CSV export.

## Where it lives in the admin menu

- **Limits:** **Configuration → AI → Budget Control**
  (`/admin/config/ai/budget`) — add, edit, and delete usage limits.
- **Usage dashboard:** **Reports → AI Usage** (`/admin/reports/ai-usage`), with a
  CSV download at `/admin/reports/ai-usage/export`.

Access is controlled by two permissions: **Administer AI budget control**
(create/manage limits and export — grant this only to trusted admins) and
**View AI usage dashboard** (read‑only access to the reports).
