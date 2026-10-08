# Metabase Integration — manual setup guide

**Metabase Integration** (`metabase`) embeds dashboards from a
[Metabase](https://www.metabase.com/) business-intelligence instance directly into
your Drupal site. Instead of hand-writing iframes or custom theming, it adds a
**Metabase Dashboard block type** that you place through Drupal's normal block
layout — pick a region, point it at a dashboard, and the chart or report renders
inline.

Access is handled with Metabase's **signed embedding** mechanism: the module
builds a signed, token-based embed URL from a secret key you configure, so dashboard
access stays controlled and no credentials are hardcoded into block configuration.
It has no module dependencies, works on Drupal 9.5 through 11, and adds no
server-side performance cost of its own.

It suits both internal, admin-only analytics and user-facing reporting. Because it
embeds content from your Metabase server and relies on a signing secret, treat that
secret carefully, keep embeds scoped to non-sensitive dashboards (or restrict the
block to appropriate roles), and serve everything over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the Metabase URL and signing
   secret, then place and configure a dashboard block.

## Where it lives in the admin menu

The module adds no dedicated settings page. Its connection details live in
`settings.php` (site URL and secret key), and the dashboards themselves are placed
from **Structure → Block layout** (`/admin/structure/block`) by adding a
**Metabase Dashboard** block. See [Configuration](configuration/index.md) for the
full walk-through.
