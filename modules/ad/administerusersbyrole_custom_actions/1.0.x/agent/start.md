<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Administer Users by Role for blocking — agent orientation

**Machine name:** `administerusersbyrole_custom_actions`  
**Version dir:** `1.0.x`  
**Core:** `^8 || ^9 || ^10`  
**Dependencies:** administerusersbyrole  
**Configure route:** `n/a`

## What it does
Lets sub-admins block/unblock only users whose roles are marked safe in Administer Users by Role.

## Where to look
- `administerusersbyrole_custom_actions.info.yml` — metadata and dependencies.
- `administerusersbyrole_custom_actions.routing.yml` / `.permissions.yml` / `.services.yml` — routes, permissions, services (where present).
- `src/` — controllers, forms, plugins and services.

See `../usage.md` for install, configuration and usage details.
