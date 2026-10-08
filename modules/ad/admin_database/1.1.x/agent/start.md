<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Database — agent orientation

**Machine name:** `admin_database`  
**Version dir:** `1.1.x`  
**Core:** `^9 || ^10`  
**Dependencies:** none  
**Configure route:** `admin_database`

## What it does
Embeds the Adminer database tool inside the Drupal admin to manage the site database.

## Where to look
- `admin_database.info.yml` — metadata and dependencies.
- `admin_database.routing.yml` / `.permissions.yml` / `.services.yml` — routes, permissions, services (where present).
- `src/` — controllers, forms, plugins and services.

See `../usage.md` for install, configuration and usage details.
