# Frontend Asset Debugger — manual setup guide

**Frontend Asset Debugger** (`frontend_asset_debugger`) is a set of admin reports
that help you understand — and trim — the CSS and JavaScript your Drupal site loads.
It analyzes the asset libraries declared across core, contrib, and your themes and
surfaces the things that quietly slow a site down: duplicate files, libraries that
are loaded but never used, render‑blocking assets, per‑component asset usage, and a
dependency graph showing how libraries relate.

The reports live under **Reports** in the admin menu. Behind them, an
`AssetAnalyzer` service inspects Drupal's library discovery, theme manager, module
handler, and theme extension list to build its findings entirely from your site's
declared libraries. Optionally, a separate `PageScanner` can fetch a set of
front‑end URLs and observe which libraries *actually* load on real pages, enriching
the reports with real‑world usage rather than just declarations. Every report has a
CSV/JSON export, so you can hand findings to a build or performance task.

It's aimed at modern Drupal front ends — Layout Builder and Single Directory
Components included — and it's read‑only where it counts: the reports themselves are
gated by a non‑restricted permission suitable for developers, while running scans and
changing settings require a separate, restricted admin permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, running a page scan,
   permissions, and where each report lives.

## Where it lives in the admin menu

The reports are under **Administration → Reports → Frontend assets**
(`/admin/reports/frontend-assets`), and the settings and scan actions are at
**Administration → Configuration → Development → Frontend assets**
(`/admin/config/development/frontend-assets`, route
`frontend_asset_debugger.settings`). See [Configuration](configuration/index.md).

## How to use it

1. Open the overview report at **Reports → Frontend assets** to see all declared asset
   libraries at a glance.
2. Drill into the specific reports — **duplicates**, **unused**, **render‑blocking**,
   **per‑component**, and the **dependency graph** — to find what to optimise.
3. *(Optional)* Run a **page scan** (see [Configuration](configuration/index.md)) to
   record which libraries load on real URLs, then compare that against what's merely
   declared.
4. **Export** any report section to CSV or JSON to feed the findings into a
   performance‑optimisation task.
