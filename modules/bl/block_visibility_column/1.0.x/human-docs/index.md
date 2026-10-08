# Block Visibility Column — manual setup guide

**Block Visibility Column** (`block_visibility_column`) adds a **Visibility**
column to Drupal's Block Layout administration page. Core lists every placed
block by region, but to find out *where* or *for whom* a given block appears you
normally have to open each block's configuration one at a time. This module
surfaces each block's visibility conditions — the pages, roles, content types
and other rules already configured on it — directly in the block list.

It changes nothing about how blocks behave: it only *displays* configuration
that already exists, so it is safe to leave enabled. On a site with many blocks
and layered visibility rules, it turns an audit that used to mean clicking into
dozens of blocks into a single glance down one column. It depends only on core's
Block module and needs no configuration beyond being enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Once enabled, the module works immediately — there is no settings form. Go to
**Structure → Block layout** (`/admin/structure/block`) and you'll see the new
**Visibility** column alongside each placed block, showing its conditions
(pages, roles, content types, and so on) at a glance.
