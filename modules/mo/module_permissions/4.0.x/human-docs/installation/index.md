# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No PHP version constraint beyond what your Drupal core requires.
- **No third‑party module or library dependencies.**

## Install with Composer

From the project root:

```bash
composer require drupal/module_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_permissions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_permissions -y
```

## Submodules

Module Permissions ships one submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Module Permissions UI** | `module_permissions_ui` | The administrative screen for curating the managed allow/deny list of modules. Enable this if you want to edit the managed list through the browser. |

Enable it with:

```bash
drush en module_permissions_ui -y
```

## Verify it worked

Once enabled, go to **People → Permissions** (`/admin/people/permissions`) and
confirm you can see the delegated module‑management permission provided by Module
Permissions. Then continue to [Configuration](../configuration/index.md) to curate
the managed module list and grant the permission to a role.
