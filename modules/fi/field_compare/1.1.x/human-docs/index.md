# Field Compare — manual setup guide

**Field Compare** (`field_compare`) is a read‑only **report** that helps site
builders keep field configuration consistent. Instead of clicking through dozens of
separate field configuration pages, you get an overview — per entity type — of all
the fields across all its bundles, side by side, so differences in **field storage
and instance settings** that are easy to miss become obvious at a glance.

It is a non‑destructive auditing tool that lives under Drupal's **Reports** section.
Nothing it does changes content or configuration; it only surfaces information.

> **Note:** this module targets **Drupal 10** and is marked **unsupported / no
> further development** by its maintainers. It remains a useful audit aid, but bear
> that status in mind for long‑term use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** to fill in — the report is configured inline as you
view it, described in "How to use it" below.

## Where it lives in the admin menu

The report is at **Reports → Field compare** (`/admin/reports/field-compare`),
gated by the dedicated **"access field compare"** permission (a restricted
permission you grant only to trusted roles). You can drill into a specific entity
type at `/admin/reports/field-compare/{entity_type}` — for example
`/admin/reports/field-compare/node`.

## How to use it

1. Grant the **"access field compare"** permission to the roles that need it
   (**People → Permissions**).
2. Go to **Reports → Field compare** and pick the entity type you want to audit
   (e.g. node).
3. Read the side‑by‑side overview to spot inconsistencies — differing cardinality,
   required flags, defaults, storage vs. instance settings, and near‑duplicate
   fields.
4. Use the **overview settings** on the report to choose which columns / settings
   are displayed; the table updates via AJAX as you toggle them.

It is well suited to content‑modeling clean‑ups, planning field consolidation, QA
before a configuration export, and comparing source vs. target field config during
a migration.
