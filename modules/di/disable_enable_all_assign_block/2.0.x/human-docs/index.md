# Disable And Enable All Assign Block — manual setup guide

**Disable And Enable All Assign Block** (`disable_enable_all_assign_block`) gives
administrators a single form to switch **every block assigned to a chosen theme
region on or off at once**, instead of toggling blocks one at a time on the Block
layout page. The classic case: a client asks you to hide the whole right sidebar for
a while, and later to bring it back. Rather than disabling each block in that region
by hand and remembering them all later, you tick one checkbox to disable the region
and untick it to restore everything.

The form lists the regions of your site's **default theme** as checkboxes. Ticking a
region's box **disables** every block currently assigned to it; leaving it unticked
**enables** every block in that region. When you save, the module updates each of
those block entities accordingly. Your region selection is stored as configuration,
so it is visible and exportable like any other Drupal config.

This is purely an administrative site-building convenience. It has no anonymous or
web-service endpoints — everything is behind the powerful **Administer site
configuration** permission. One behaviour to keep in mind: the toggle is
**region-wide** and applies to the default theme, so unticking a region re-enables
*all* of that region's blocks, not just the ones you personally switched off. It
depends on core's Block module and runs on Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the region checkboxes and how the
   enable/disable toggle behaves.

## Where it lives in the admin menu

The module adds a section at `/admin/config/disable_enable_all_assign_block` and a
settings form (route `disable_enable_all_assign_block.settings_advanced`), both
behind the **Administer site configuration** permission.
