<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity UUID Lookup (entity_uuid_lookup) — agent index

Admin utility: enter an entity **UUID** and get redirected to that entity's **canonical or edit URL**. Version
**1.1.x**. Core `^8.8 || ^9 || ^10 || ^11`, PHP 7.4. Package "User interface". No dependencies, no configuration,
no config schema.

## What it provides
- **Route** `entity_uuid_lookup.admin` → `/admin/content/by-uuid`, renders the lookup form. Requires BOTH
  permissions `lookup entities by uuid` AND `view the administration theme`.
- **Permission** `lookup entities by uuid` (`entity_uuid_lookup.permissions.yml`).
- **Form** `EntityUuidLookupForm` — the UUID entry form with View/Edit submit buttons.
- **Block plugin** `navigation_entity_uuid_lookup` (`NavigationEntityUuidLookupBlock`) — a Navigation-module
  menu item; `hook_block_alter` marks it `allow_in_navigation` and hidden from Block UI.
- **Toolbar item** via `hook_toolbar()` (opens the form in an 800px modal).
- **Menu link** `entity_uuid_lookup.admin` under `system.admin_content`.
- **Icon pack** `entity_uuid_lookup` (`entity_uuid_lookup.icons.yml`, SVG) and libraries `toolbar`/`navigation`
  (CSS only).

## Solution docs
- [Lookup form, route & permissions](forms/lookup.md)
- [Toolbar, navigation block & entry points](blocks/navigation.md)
