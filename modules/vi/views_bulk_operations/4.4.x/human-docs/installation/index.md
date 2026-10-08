# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`) — this is a dependency and is enabled by
  default in a standard install.
- **Drush 12 or 13** is *suggested* (not required) if you want to run a view's
  bulk action from the command line with `drush vbo-execute`.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_bulk_operations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_bulk_operations -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_bulk_operations -y
```

Enabling VBO makes the **Views bulk operations** field available in the Views UI.
It does nothing on its own until you add that field to a View — see
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Actions Permissions** | `actions_permissions` | Per‑role, per‑action access control, so you can decide which roles may run which bulk actions. Its permissions appear on **People → Permissions**. |
| **VBO Example** | `views_bulk_operations_example` | A ready‑made example View and custom action you can study when building your own bulk operations. Handy on a development site; you would not normally enable it in production. |

For example, to add per‑action permissions:

```bash
drush en actions_permissions -y
```

Each submodule requires the base Views Bulk Operations module, which is already
present once you have installed it above.
