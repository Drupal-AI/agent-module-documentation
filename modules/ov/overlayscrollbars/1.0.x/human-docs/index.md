# OverlayScrollbars — manual setup guide

**OverlayScrollbars** (`overlayscrollbars`) integrates the
[OverlayScrollbars](https://kingsora.github.io/OverlayScrollbars/) JavaScript
plugin into Drupal, replacing the browser's native scrollbars with custom,
overlay‑style ones. The result is a consistent, tidy scrollbar appearance across
browsers and operating systems — the scrollbars overlay the content rather than
taking up their own strip of layout space.

You don't have to apply it everywhere. The module provides a **settings page**
where you specify which HTML elements should get the OverlayScrollbars treatment,
so you can target just the containers where custom scrollbars improve the design.
This is a purely presentational, front‑end enhancement — it has no effect on
content or access beyond its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module's setup happens on its settings page, described below.

## How to use it

1. Install and enable the module (see Installation), and grant its permission to
   the roles that should administer it.
2. Open the module's **settings page**, where you define the HTML elements
   (selectors) that should receive OverlayScrollbars.
3. Enter the elements you want the plugin applied to, save, and reload the site —
   the targeted elements now use the custom overlay scrollbars.

Because this only changes how scrollbars look, it's safe to try on a few
containers first and expand the selection once you're happy with the result.
