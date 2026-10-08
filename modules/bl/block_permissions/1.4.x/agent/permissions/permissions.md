<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`block_permissions.permissions.yml` contains **no static permissions** — only:

```yaml
permission_callbacks:
  - Drupal\block_permissions\BlockPermissionsPermissions::permissions
```

## Family 1 — per theme

```
administer block settings for theme <theme_machine_name>
```

- Title: *"Administer block settings for the theme @Label"*, description
  *"This permission refines the administer blocks permission."*
- Emitted for every theme in `theme_handler->listInfo()` where `status == 1` and the theme is
  not `hidden: true` in its info file. (Hidden themes such as engine sub-themes get no
  permission.)
- Examples on a stock site: `administer block settings for theme olivero`,
  `administer block settings for theme claro`.

## Family 2 — per block provider

```
administer blocks provided by <provider>
```

- Title: *"Manage blocks provided by @label"*, description *"When not given, the user cannot
  manage blocks provided by this provider."*
- `<provider>` is the `provider` key of each block plugin definition from
  `plugin.manager.block` — a module (or theme) machine name, plus `core` for
  core-provided derivatives. So `administer blocks provided by system`,
  `… by block_content`, `… by views`, `… by user`, `… by core`, …

## Listing them on a live site

```bash
drush php:eval '
  foreach (array_keys(\Drupal::service("user.permissions")->getPermissions()) as $p) {
    if (str_starts_with($p, "administer block settings for theme") || str_starts_with($p, "administer blocks provided by")) {
      print $p . "\n";
    }
  }'
```

## Granting

```bash
drush role:perm:add site_editor 'administer blocks'                          # core, still required
drush role:perm:add site_editor 'administer block settings for theme olivero'
drush role:perm:add site_editor 'administer blocks provided by block_content'
drush cget user.role.site_editor permissions
```

```php
$role = \Drupal\user\Entity\Role::load('site_editor');
$role->grantPermission('administer block settings for theme olivero');
$role->grantPermission('administer blocks provided by block_content');
$role->save();
```

## Combining rules (from `BlockPermissionsAccessControlHandler`)

| Action | Needs |
|---|---|
| Block layout page for the default theme (`/admin/structure/block`) | `administer block settings for theme <system.theme:default>` |
| Block layout page for theme X (`/admin/structure/block/list/X`) | `administer block settings for theme X` |
| "Place block" library for theme X | `administer block settings for theme X` (rows are then filtered per provider) |
| Add a block of plugin P to theme X | `administer blocks provided by <P's provider>` **and** `administer block settings for theme X` |
| Edit / delete an existing block | `administer blocks provided by <the block's configured provider>` |
| Drag / reorder a row on Block layout | `administer blocks provided by <that block's provider>` — otherwise the row is frozen |

Because these are *additional* `_custom_access` requirements on core routes, core's own
`administer blocks` permission is still checked; both must pass.

**Common gotcha:** a role with `administer blocks` and only a *provider* permission still
gets 403 on `/admin/structure/block` — the default theme's permission is what opens the page
(this is called out in the module's README).
