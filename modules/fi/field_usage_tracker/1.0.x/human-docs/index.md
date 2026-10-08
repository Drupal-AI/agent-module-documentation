# Field Usage Tracker — manual setup guide

**Field Usage Tracker** (`field_usage_tracker`) gives you a **single report of where
every field is used across your site** — which content types and other entities a
field is attached to, whether it appears in any Views, and whether it's referenced
in custom PHP code. That combined view makes it a handy tool for site audits, field
cleanup, and refactoring: before you change or remove a field, you can see at a
glance what depends on it.

The report is gated by the module's own permission, so only administrators or
site‑builders you trust can see it. The module has no other access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration to do** — the module works as soon as it's enabled.
You view its report, described in "How to use it" below.

## How to use it

1. Under **People → Permissions**, grant the module's permission to the roles that
   should be able to view the report.
2. Navigate to **`/admin/reports/field-usage`**.
3. Review the report. For each field it shows the target entity and bundle, whether
   the field is used in any **Views** (detected from Views configuration), and
   whether it's referenced in **custom code** (found by scanning custom module
   folders for the field's machine name).

Use it when refactoring content types, removing unused fields, or auditing a site.

> **Note:** Views usage can only be detected if the core **Views** module is
> enabled, and code detection scans your custom module folders for field machine
> names.
