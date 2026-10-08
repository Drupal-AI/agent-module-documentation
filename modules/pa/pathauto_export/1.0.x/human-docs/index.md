# Pathauto export — manual setup guide

**Pathauto export** (`pathauto_export`) is a simple utility that exports the URL
aliases managed by **Pathauto** into a **CSV file**. It's handy whenever you need a
portable copy of your site's aliases — to back them up, to review the aliases
Pathauto has generated, or to hand them off before a migration to another
environment. You can export aliases **by type** (for example just node aliases, or
just media aliases) or **all of them at once**.

It's an import/export helper: it reads and exports alias data and has no content or
access‑control role of its own. It depends on the Pathauto module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Pathauto is required).

This module has **no settings form** — there's nothing to configure. It provides
an export action, described under "How to use it" below.

## Where it lives in the admin menu

The module adds an export action rather than a settings page. You reach it from the
Pathauto/URL‑aliases area of the admin interface (**Configuration → Search and
metadata → URL aliases**), where the export option is available.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). Pathauto must be
   installed and have generated some aliases.
2. Open the module's export action from the URL‑aliases admin area.
3. Choose whether to export a specific entity type (node, media, etc.) or **all**
   aliases at once.
4. Run the export and save the resulting **CSV** file for backup, review, or
   transfer to another environment.
