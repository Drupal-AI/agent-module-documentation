<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alerts - Olivero (alerts_olivero) — agent index

Submodule of [Alerts Kit](../../../../agent/start.md). Formatting enhancements for displaying alert banners with the Olivero theme: header-banner CSS plus click-to-dismiss JavaScript backed by `localStorage`. No PHP entities, routes, permissions, services, or config schema.

- **Version:** 1.1.x (installed 1.1.1) · **Core:** `^8 || ^9 || ^10 || ^11` · **Package:** Configuration Kits
- **Requires:** `alerts` (parent)
- **Library deps:** `core/drupal`, `core/once`

## What it provides
- **`alerts_olivero_views_pre_render()`** (`alerts_olivero.module`): for the `alerts` view, attaches library `alerts_olivero/olivero_display`.
- **Library `olivero_display`** (`alerts_olivero.libraries.yml`): `css/olivero-display.css` + `js/alerts-dismiss.js`.
- **Block placement** (`config/install/block.block.views_block__alerts_block_1.yml`): puts `views_block:alerts-block_1` into Olivero's `header` region.

## Solution docs
- `agent/theming/display.md` — the CSS/JS behavior: banner layout, the `Drupal.behaviors.alertsDismiss` dismissal flow, and the localStorage contract.
