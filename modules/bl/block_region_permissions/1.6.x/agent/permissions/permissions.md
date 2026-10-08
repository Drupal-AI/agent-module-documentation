<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

The module provides **no static permissions file entries**; instead
`block_region_permissions.permissions.yml` declares a `permission_callbacks` entry pointing at
`Drupal\block_region_permissions\Permissions::get`, which **dynamically generates one
permission per region of every enabled, non-hidden theme**.

## Generated permission per region

For each enabled theme (skips themes that are disabled or have `hidden: true` in their info)
the callback reads the theme's `regions` and emits:

- **Machine name:** `administer {theme_key} {region_key}`
  e.g. `administer claro sidebar_first`, `administer olivero header`, `administer claro content`.
- **Title:** `Administer: <em>{Theme name}</em> - <em>{Region name}</em>`
  e.g. "Administer: Claro - First sidebar".

`{theme_key}` is the theme machine name; `{region_key}` is the region machine name from theme
info (e.g. `content`, `header`, `sidebar_first`, `footer`, `breadcrumb`). New regions/themes
appear as new permissions automatically — nothing to configure.

## What the region permission gates

Holding `administer {theme} {region}` lets a user, **for that theme's region only**:

1. **See its blocks on the Block layout page** — `block_admin_display_form` is altered
   (`block_region_permissions_form_block_admin_display_form_alter`); block rows for regions the
   user lacks permission for are removed. The theme shown is the URL theme
   (`/admin/structure/block/list/{theme}`) or the default theme at `/admin/structure/block`.
2. **Choose the region in region-select fields** — region options the user cannot administer
   are stripped from the dropdowns on both the layout form and the block add/configure form
   (`block_region_permissions_form_block_form_alter`).
3. **Edit and delete blocks in that region** — enforced two ways:
   - `hook_block_access()` (`block_region_permissions_block_access`) returns
     `AccessResult::forbiddenIf(!hasPermission("administer $theme $region"))` for the
     `update` and `delete` operations (the `disabled`/none region, key `-1`, is skipped). This
     also hides the block's contextual operation links.
   - A **route subscriber** (`Routing\RouteSubscriber`) adds
     `_custom_access: Drupal\block_region_permissions\AccessControlHandler::blockFormAccess`
     to the `entity.block.edit_form` and `entity.block.delete_form` routes, so a direct URL is
     access-checked, not just hidden. `blockFormAccess()` returns
     `AccessResult::allowedIfHasPermission($account, "administer $theme $region")`.

## Required core permission and its caveat (important)

- **`administer blocks`** (core Block module) is still **required** to reach the Block layout
  UI at all. This module filters *within* that page; it does not replace the core permission.
- **Caveat:** "Administer blocks" on its own grants access to block pages this module does
  **not** manage — e.g. `entity.block.disable`/`enable`, `block.admin_library` (place-block
  search), `block.admin_add`. To fully restrict those, pair with the recommended
  **Block Content Permissions** module. Do not assume region permissions alone sandbox a user.

## Related permissions the README calls out (all core, not provided here)

To make a delegated block-editing role behave well, the README also suggests granting, as
appropriate: Contextual Links "Use contextual links" (this module hides links accordingly),
Quick Edit "Access in-place editing", System "Use the administration pages and help" and
"View the administration theme", and Toolbar "Use the toolbar".

## Grant via Drush

```bash
drush role:perm:add editor 'administer claro content'
drush role:perm:add editor 'administer olivero sidebar_first'
# still required to reach the page:
drush role:perm:add editor 'administer blocks'
```
