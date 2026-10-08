<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config object

File: `src/Form/ConfigForm.php` (extends `Drupal\Core\Form\ConfigFormBase`).
Form id: `asset_purge_manager_config_form`. Route:
`asset_purge_manager.admin_page` → `/admin/config/media/asset_purge_manager`
(permission **`administer Asset Purge Manager`**; menu link under Configuration › Media,
`system.admin_config_media`).

## Config object

`asset_purge_manager.settings` — the only editable config
(`getEditableConfigNames()`). Single key:

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `num_per_page` | integer | `25` | Number of files shown per page on the purge form's `tableselect`. |

- Install default: `config/install/asset_purge_manager.settings.yml` (`num_per_page: 25`).
- Schema: `config/schema/asset_purge_manager.schema.yml` — `config_object` mapping with
  `num_per_page` (`integer`).

## Form behaviour

- `buildForm()` renders one `textfield` `num_per_page` (default from config) under an
  "Asset Purge Manager" heading, then `parent::buildForm()` adds the standard save button.
- `submitForm()` casts the value to `(int)` and saves it to `asset_purge_manager.settings`
  (`->set('num_per_page', (int) $value)->save()`), then `parent::submitForm()`.
- There is **no `validateForm()`** (the commented-out stub notes it is "space & weight only"),
  so any numeric-ish string is coerced to an int; a non-positive value would make the pager slice
  empty, but this route is admin-only.

## Set it from the CLI

```
drush config:set asset_purge_manager.settings num_per_page 50 -y
```

The module injects `current_user` and `module_handler` into this form but does not otherwise use
them for access control — access is enforced solely by the route's
`administer Asset Purge Manager` permission.
