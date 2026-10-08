# Thin Progress Bar — manual setup guide

**Thin Progress Bar** (`thin_progress_bar`) adds a slim, animated loading bar
across the very top of the page — the NProgress-style indicator you have seen on
many modern sites. Its distinguishing trick is that it is *smart*: instead of
flashing on every single page load, it only appears when a load is actually slow
(longer than a threshold you set, 800ms by default). Fast pages stay clean with no
bar at all; slow pages get real loading feedback. It can also show during AJAX
operations when you enable that.

The module works the moment you enable it, with sensible defaults and no
configuration required. If you want to fine-tune it, an optional settings section
lets you adjust the threshold, the bar's color and thickness (1px or 2px), the
animation speed, and whether it runs for page loads and/or AJAX. It is a purely
front-end, presentational enhancement — it has no content or access role, adds no
menu items, and has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the optional settings for threshold,
   appearance, and AJAX behavior.

## Where it lives in the admin menu

The bar is active immediately once enabled. Its optional settings live on the
appearance settings page at **Appearance → Settings**
(`/admin/appearance/settings`).
