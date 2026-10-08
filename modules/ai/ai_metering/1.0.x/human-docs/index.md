# AI Metering — manual setup guide

**AI Metering** (`ai_metering`) is the accounting and cost-control layer for a
Drupal site that uses AI. Whenever any code calls an AI provider through
Drupal's **AI** module — for any provider, any operation — AI Metering records
how many tokens the call used and what it cost in USD, storing every call in its
own database log. On top of that it adds per-user monthly **quotas**, a cost
**dashboard** for editors and managers, and the ability to show costs in any
currency using live exchange rates.

It works by listening in on the AI module's request events. *Before* a call it
can estimate the cost and enforce a per-user monthly token budget — optionally
rerouting an over-budget user to a cheaper or local model instead of blocking
them. *After* the call it logs the input, output, and cached token counts along
with the computed cost. Per-model pricing comes from pluggable sources (LiteLLM
and models.dev) that you can sync on demand, and it is provider-agnostic:
OpenAI, Anthropic, Ollama, and others are all metered the same way, with
provider-native token counting for Anthropic and Ollama where that's more
accurate.

Administrators get a settings hub, a per-editor cost dashboard, a
breakdown by role, and a raw usage log — all exportable to CSV or JSON via
Views. Five Drush commands cover quota resets, setting budgets, syncing pricing,
and pulling reports from a LiteLLM proxy. Nothing is stored as config or content
entities; usage lives in the `ai_metering_usage` table and budgets in
`ai_metering_quota`.

It optionally integrates with **AI Usage Limits** (a read-only provider-ceiling
banner on the dashboard) and **AI Translate** (a pre-call cost badge). This is a
**beta** release.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the AI
   and Views Data Export dependencies, and enable the module.
2. [Configuration](configuration/index.md) — the settings hub, quotas, model
   routing, pricing sync, currency, permissions, and the Drush commands.

## Where it lives in the admin menu

- **Settings hub:** **Configuration → AI → AI Metering**
  (`/admin/config/ai/ai-metering`).
- **Cost dashboard:** **Reports → AI Metering** (`/admin/reports/ai-metering`),
  with a per-role breakdown at `/admin/reports/ai-metering/by-role`.
- **Usage log export:** `/admin/reports/ai-metering/export/csv` and `/export/json`.

## How to use it

Once installed and enabled, metering is **automatic** — every AI call through
the AI module is logged without any further wiring. From there you typically:

1. Visit the **settings hub** to set model routing, a display currency, and how
   pricing is sourced (see [Configuration](configuration/index.md)).
2. Run a pricing sync so costs are calculated from current model prices.
3. Set per-user monthly **budgets** (via the UI or `drush aim-budget`) if you
   want to cap spend, and decide whether over-budget calls fall back to a
   cheaper model.
4. Watch spend on the **dashboard**, and grant editors the dashboard permission
   so they can see their own costs.
