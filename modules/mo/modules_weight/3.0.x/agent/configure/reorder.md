<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reordering modules and settings

## Where a module's weight lives

Module weights are stored in the **`core.extension`** config object under
`module.<machine_name>` (an integer; **lower runs earlier**). Modules Weight is a friendly
front end over core's `module_set_weight($module, $weight)`; it does not invent its own
storage.

```bash
drush config:get core.extension module      # see all module weights
```

```php
module_set_weight('mymodule', 5);            # what the module does under the hood
```

## The reorder form

Route `modules_weight.list_page` at **`/admin/config/system/modules-weight`**
(`ModulesListForm`). Lists each installed, compatible module with an editable weight; saving
writes the new weights to `core.extension`. Whether Core (`package: Core`) modules appear is
governed by the setting below.

## The settings page

Route `modules_weight.modules_weight_admin_settings` (the module's `configure` route) at
**`/admin/config/system/modules-weight/configuration`** (`ModulesWeightAdminSettings`). One
option, stored in config `modules_weight.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `show_system_modules` | boolean | `FALSE` | Show/allow reordering of Drupal Core modules in the list. |

```bash
drush config:set modules_weight.settings show_system_modules true -y
```

## Permission

Both pages require **`administer modules weight`**.
