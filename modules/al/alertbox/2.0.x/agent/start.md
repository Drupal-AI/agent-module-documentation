<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alertbox — agent orientation

**Machine name:** `alertbox`  
**Version dir:** `2.0.x`  
**Core:** `^8.8 || ^9 || ^10`  
**Dependencies:** drupal:block_content, drupal:text, drupal:options  
**Configure route:** `alertbox.settings`

## What it does
Creates alert boxes (via block_content) to display information banners across the site.

## Where to look
- `alertbox.info.yml` — metadata and dependencies.
- `alertbox.routing.yml` / `.permissions.yml` / `.services.yml` — routes, permissions, services (where present).
- `src/` — controllers, forms, plugins and services.

See `../usage.md` for install, configuration and usage details.
