# EZ Likes — manual setup guide

**EZ Likes** (`ez_likes`) adds a lightweight, self-hosted engagement bar to the
bottom of your node pages, and gives administrators a report of how content is
being shared. It's built to work with just Drupal core — no contributed modules,
no third-party analytics service, and no external JavaScript. On any node whose
**full** view mode is built with **Layout Builder**, EZ Likes injects a compact
action bar with a **Share** button that copies the page's canonical URL to the
clipboard (with a friendly toast, and a fallback for older browsers).

Every share interaction is recorded in a dedicated database table and
deduplicated, so the counts stay meaningful. Administrators get a built-in report
showing share counts per node, with sortable columns, filters by content type and
title, a per-node detail view of who interacted, and one-click **CSV export** —
enough to see what's resonating without wiring up a heavyweight analytics
integration. It fits news sites, knowledge bases, intranets, and community
portals.

A few thoughtful touches are worth knowing. The button is fully accessible
(`aria-label` and `aria-live` regions). You control exactly which pages show it
with an enabled-content-types list plus per-path include and exclude rules
(wildcards supported). The button colour is configurable, with dark/tint/shadow
variants computed automatically. And your data is treated with care: on uninstall
the tables are renamed to a preserved backup rather than dropped, and restored
automatically if you reinstall.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose where the button appears, set
   its colour, grant the report permission, and read the report.

## Where it lives in the admin menu

- **Settings** at **Configuration → Content → EZ Likes**
  (`/admin/config/content/ez-likes`) — behind the **Administer EZ Likes**
  permission.
- **The report** at **Reports → EZ Likes Report** (`/admin/reports/ez-likes`) —
  behind the restricted **Access EZ Likes report** permission.

## How to use it

The button appears automatically — on full-view-mode node pages that use Layout
Builder — as soon as the module is enabled; a default setup needs no further
configuration. The important prerequisite is that a node's **full** display is
built with **Layout Builder**, since that's how the button gets injected. From
there, use the [Configuration](configuration/index.md) page to narrow down which
content types and paths show the button and to open up the analytics report to
your editors.
