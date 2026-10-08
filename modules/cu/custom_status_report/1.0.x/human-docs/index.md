# Custom Status Report — manual setup guide

**Custom Status Report** (`custom_status_report`) lets you tailor Drupal's core
**Status Report** page (`/admin/reports/status`). Out of the box that page shows a
fixed set of "General System Information" cards and offers no way to change what
appears. This module adds that control: you can **hide** any of the default cards
you don't care about, and **add** custom cards — supplied by your own module (or
any other module that supports this) — so all the statuses you actually track live
in one place.

It's a lightweight administration utility. It only affects an admin-only report,
has no front-end role, and doesn't change any content or access. It supports
Drupal 9, 10, and 11 and has no dependencies beyond core, so it's safe to enable
whenever you want a cleaner, more focused status report.

After installing, the module adds a small configuration page where you choose which
cards to show or hide — so it does need a quick pass through settings to be useful.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which status cards appear.

## Where it lives in the admin menu

Once enabled, the module's settings live at **Configuration → System → Custom
Status Report** (`/admin/config/system/custom-status-report`), where you show or
hide the available cards. The report you're customizing is the core page at
**Reports → Status report** (`/admin/reports/status`).
