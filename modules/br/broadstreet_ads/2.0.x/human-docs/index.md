# Broadstreet Ads — manual setup guide

**Broadstreet Ads** (`broadstreet_ads`) puts ads from the
[Broadstreet](https://broadstreetads.com/) advertising platform onto your Drupal
site as placeable blocks. Instead of hand‑coding ad markup into templates, you
register your Broadstreet **ad zones** once, and the module turns each zone into a
block you can drop into any theme region using Drupal's normal block layout.

You define your zones on a settings form as simple `zoneid|Label` lines. For each
one, the module creates a block that outputs Broadstreet's `<broadstreet-zone>`
web component (with the zone ID cast to an integer). Broadstreet's loader script is
attached only on non‑admin pages, and only when you actually have at least one zone
configured — so a site with no zones loads no ad script, and ads never appear on
admin pages.

Ad delivery happens client‑side through Broadstreet's own script; Drupal itself
makes no outbound ad requests. Configuration is restricted to users with the
module's custom **Administer Broadstreet ads** permission.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — registering your ad zones and placing
   the resulting blocks.

## Where it lives in the admin menu

Its settings form is at **Configuration → Services → Broadstreet Ads**
(`/admin/config/services/broadstreet-ads`), protected by the **Administer
Broadstreet ads** permission. The per‑zone ad blocks it creates are placed under
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter your Broadstreet zone IDs and labels on the settings form (see
   [Configuration](configuration/index.md)).
3. Place the resulting per‑zone ad blocks into the theme regions where you want
   ads, using Drupal's Block layout screen (block visibility conditions let you
   target specific pages).
