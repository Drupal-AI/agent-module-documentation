<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AddToAny Field — agent orientation

**Machine name:** `addtoany_field`  
**Version dir:** `2.0.x`  
**Core:** `^9.4 || ^10.0`  
**Dependencies:** drupal:node, drupal:link, addtoany:addtoany  
**Configure route:** `n/a`

## What it does
Provides a field type that renders AddToAny share links on entities.

## Where to look
- `addtoany_field.info.yml` — metadata and dependencies.
- `addtoany_field.routing.yml` / `.permissions.yml` / `.services.yml` — routes, permissions, services (where present).
- `src/` — controllers, forms, plugins and services.

See `../usage.md` for install, configuration and usage details.
