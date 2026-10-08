# Layout Builder Usage Reports — manual setup guide

**Layout Builder Usage Reports** (`layout_builder_usage_reports`) adds a single
admin report that inventories how **Layout Builder** is used across your site. It
lists every node that overrides its Layout Builder layout, together with the inline
blocks, block types, paragraph components, and paragraph types placed inside those
layouts — with filters to narrow the results.

It's a read‑only auditing tool. If you're planning a refactor, a migration, or a
redesign, this report answers questions like "which nodes still use this old block
type?", "where is this paragraph component actually placed?", "which module
provides each component?", and "how widely has Layout Builder been adopted here?".
Each listed node links straight to itself so you can jump in and investigate.

The module adds no code API, no configuration to store, and no display of its own —
it simply queries your existing node layouts and presents them in a filterable
table. It depends only on core's **Layout Builder** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the report page, its columns, and the
   filters (this is a report rather than a settings form).

## Where it lives in the admin menu

Once enabled, the report sits at **Reports → Layout Builder Usage Report**
(`/admin/reports/layout/usage`). Reaching it requires the restricted **Access node
layout reports** permission.

## How to use it

Grant the **Access node layout reports** permission to the roles that should audit
layouts, then open **Reports → Layout Builder Usage Report** and use the filters at
the top to narrow the list by content type, provider, language, block type, or
paragraph type. See [Configuration](configuration/index.md) for the details.
