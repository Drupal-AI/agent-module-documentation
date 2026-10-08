# ShareThis Block — manual setup guide

**ShareThis Block** (`sharethis_block`) adds the third‑party
[ShareThis](https://sharethis.com) social‑share buttons to your Drupal site. You
enter your ShareThis account's **property ID**, choose an **inline** or **sticky**
layout, and place a block — the module loads the ShareThis platform script for
your property, and ShareThis renders the buttons.

Two layouts are available. **Inline** buttons appear wherever you place the
ShareThis block (the module outputs a container div that ShareThis fills in), so
you control the region. **Sticky** buttons are positioned by ShareThis itself
(pinned to the side or bottom of the page, configured on the ShareThis website);
in that mode the block just needs to load the script.

The actual button set, styling, and networks are all managed in your account on
sharethis.com — this module simply wires your property ID and chosen layout into
Drupal so the correct ShareThis script loads. That also means you can change the
displayed networks or button style entirely from the ShareThis dashboard without
touching your site.

> **Third‑party service note.** ShareThis is a commercial, non‑GPL external
> service. When the block is present, its JavaScript (and ShareThis's own
> tracking) runs on those pages, loaded from `platform-api.sharethis.com`. Keep
> that in mind for privacy and consent requirements.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your property ID, choose the
   layout, and place the block.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Sharethis**
(`/admin/config/user-interface/sharethis`), reachable by users with the
**Administer sharethis_block** permission (the one permission this module adds).
You place the actual buttons block at **Structure → Block layout**.

## How to use it

1. Get your **property ID** from your ShareThis account (on sharethis.com, under
   "Get The Code," it's the value after `#property=`).
2. Enter it on the settings form and pick **Inline** or **Sticky**.
3. Place the **ShareThis** block at **Structure → Block layout** in the region you
   want (region placement matters for inline; for sticky, ShareThis handles the
   positioning).

The full walkthrough is in the [Configuration](configuration/index.md) guide.
