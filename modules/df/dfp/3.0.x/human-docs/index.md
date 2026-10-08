# Doubleclick for Publishers (DFP) — manual setup guide

**Doubleclick for Publishers** (`dfp`) integrates Google Ad Manager / Google
Publisher Tags (GPT) into a Drupal site. You define reusable **ad tags** — each
one describing an ad slot (its size, ad unit, and targeting) — and the module
injects the `googletag` JavaScript and slot definitions into the page head, so
Google's ad server can fill those slots. Each ad tag can also be exposed as a
placeable Drupal block, so you drop ads into regions with the normal Block layout
UI.

You set your Google **Network ID** once in the global settings and every tag
inherits it. Individual tags can define responsive **breakpoints** (swapping ad
sizes at different browser widths), page‑ and tag‑level **key/value targeting**
for ad selection, and AdSense backfill for when DFP inventory runs out. Ad unit
patterns and targeting values support tokens (both DFP's own `[dfp_tag:*]` tokens
and core tokens like `[current-page:*]`), and rendering can be asynchronous
(default), combined into a single request, or set to collapse empty ad divs.

A couple of handy operational features: append `?adtest=true` to any URL to route
all slots through a dedicated ad‑test unit pattern so you can preview a campaign
without touching real inventory, and output a JavaScript‑free "short tag" (an image
link) for ads embedded in email. Everything is gated by one permission,
**Administer DFP**, so grant it only to trusted ad‑ops staff. The module depends on
core's **Block** module.

This is a network/ad‑server integration: you'll need a Google Ad Manager account
and your network ID, ad units, and campaigns configured on Google's side for ads to
actually serve.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global settings, the ad‑tag
   entity field by field, blocks, and ad‑test/preview mode.

## Where it lives in the admin menu

- **Ad tags:** **Structure → DFP Ad Tags** (`/admin/structure/dfp`) — the list of
  ad tags, with add/edit/delete.
- **Global settings:** **Structure → DFP Ad Tags → Global settings**
  (`/admin/structure/dfp/settings`, route `dfp.admin_settings`).
- **Test page:** `/admin/structure/dfp/test_page`.

All of these require the **Administer DFP** permission.

## How to use it

1. In **Google Ad Manager**, set up your network, ad units, and line items — DFP in
   Drupal is the front‑end tagging layer; Google decides what actually fills each
   slot.
2. Enable the module, then open **Structure → DFP Ad Tags → Global settings** and
   enter your **Network ID** (plus any global targeting and rendering
   preferences) — see [Configuration](configuration/index.md).
3. Add an ad tag at **Structure → DFP Ad Tags** for each slot you want (size, ad
   unit, breakpoints, targeting).
4. Place the ad: leave the tag's **block** option on and add its auto‑generated
   block to a region in **Structure → Block layout**.
5. Preview by appending `?adtest=true` to a URL (or use the admin test page) before
   going live.
