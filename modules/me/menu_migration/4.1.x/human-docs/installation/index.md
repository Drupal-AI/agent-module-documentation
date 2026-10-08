# Installation

## Requirements

Menu Migration needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** (`file`) and **Custom Menu Links** (`menu_link_content`) modules.
  Drupal enables both automatically as dependencies when you turn this module on.

There are no third-party libraries or contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_migration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_migration -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_migration -y
```

## Grant permissions

Menu Migration defines five permissions on **People → Permissions**
(`/admin/people/permissions`). The first three are admin-grade (marked *restrict
access*):

| Permission | What it grants |
|------------|----------------|
| **Administer menu migration** | Everything — this bypasses all the other menu_migration permissions, and it is what the Quick Action Settings form requires. |
| **Administer menu migration export types** | Add, edit, delete, and run **Menu Export** entities. |
| **Administer menu migration import types** | Add, edit, delete, and run **Menu Import** entities. |
| **Perform export on menu migrations** | View the Menu Exports list and **run** exports, without the right to edit them. |
| **Perform import on menu migrations** | View the Menu Imports list and **run** imports, without the right to edit them. |

Grant the run-only permissions to editors who should be able to trigger existing
exports/imports but not change them, for example:

```bash
drush role:perm:add editor 'perform export on menu migrations'
```

The top-level UI at `/admin/config/development/menu-migration` also requires core's
*access administration pages* permission.

## Next steps

See [Configuration](../configuration/index.md) to create your first Menu Export /
Menu Import, set the Quick Action defaults, and run the Drush commands.
