<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Role UI — agent orientation

**Machine name:** `admin_role_ui`  
**Version dir:** `1.0.x`  
**Core:** `^9 || ^10`  
**Dependencies:** none  
**Configure route:** `n/a`

## What it does
Overrides core admin-role UI to prevent lockout and surface which roles are administrator roles.

## Where to look
- `admin_role_ui.info.yml` — metadata and dependencies.
- `admin_role_ui.routing.yml` / `.permissions.yml` / `.services.yml` — routes, permissions, services (where present).
- `src/` — controllers, forms, plugins and services.

See `../usage.md` for install, configuration and usage details.
