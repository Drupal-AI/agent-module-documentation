<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AddThis Social Share — agent orientation

**Machine name:** `addthis_social_share`  
**Version dir:** `1.2.x`  
**Core:** `^9 || ^10`  
**Dependencies:** drupal:field, drupal:block  
**Configure route:** `addthis_social_share.settings`

## What it does
Provides AddThis share buttons via a configurable block and two admin settings forms.

## Where to look
- `addthis_social_share.info.yml` — metadata and dependencies.
- `addthis_social_share.routing.yml` / `.permissions.yml` / `.services.yml` — routes, permissions, services (where present).
- `src/` — controllers, forms, plugins and services.

See `../usage.md` for install, configuration and usage details.
