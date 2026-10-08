<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Admin Theme — manual setup guide

**Layout Builder Admin Theme** (`layout_builder_admin_theme`) makes Layout
Builder's editing screens render in your site's **admin theme** (for example
Claro) instead of the front-end theme. If a custom or minimal front-end theme
makes the Layout Builder editing UI look broken, this module gives editors a
clean, predictable back-office experience while they arrange sections and blocks.

It works by switching the active theme to the site's configured admin theme
whenever you are on a Layout Builder editing form — the main layout editing UI,
plus core's "Revert to defaults" and "Discard changes" screens. The regular
front-end display of your pages is untouched; only the editing experience changes.

Everything is driven by a single on/off setting, which ships **on** by default, so
the module starts working the moment you enable it. It depends only on core's
Layout Builder, adds no permissions or Drush commands, and stores just that one
config value. Because it uses whatever theme is set as your site's admin theme,
changing your admin theme changes which theme Layout Builder editing uses.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the single on/off checkbox, and how
   to change which theme is used.

## Where it lives in the admin menu

The one-checkbox settings form sits at **Configuration → Content authoring →
Layout Builder Admin Theme** (`/admin/config/content/lbat`), and needs the
**Administer site configuration** permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). The admin-theme
   override is on immediately.
2. Open a Layout Builder editing screen — it now renders in your admin theme.
3. To turn it off, or to change which theme is used, see
   [Configuration](configuration/index.md).
