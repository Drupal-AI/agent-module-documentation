# Application Tiles — manual setup guide

**Application Tiles** (`apptiles`) generates the metadata that lets a website
appear with proper artwork when it is pinned to a device — Windows Start-menu
pinned tiles and mobile home-screen touch icons. It builds a `browserconfig.xml`
file plus the matching `<meta name="msapplication-*">` tags and icon links in the
page head, all driven by your **theme settings** rather than a separate form.

You point the module's image and colour settings at appropriately sized square
icons in your theme configuration, and a service (`AppTilesManager`) assembles the
output: it produces `browserconfig.xml` from a bundled template plus your settings,
and emits the tile/icon markup in the head. Results are cached, and generation is
skipped on admin routes, so it adds no overhead where it is not needed. Because it
works per theme, different themes can present different tiles.

It adds no permissions and no public mutation routes. Think of it as complementing
a full Progressive Web App / manifest setup — it handles the pinned-tile and
touch-icon corner rather than replacing a complete PWA configuration.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — where the tile images and colours
   live (in your theme settings) and how to apply changes.

## Where it lives in the admin menu

There is no dedicated settings page. The tile images and colours are set in your
theme's settings form under **Appearance → (your theme) → Settings**
(`system.theme_settings`). See [Configuration](configuration/index.md).
