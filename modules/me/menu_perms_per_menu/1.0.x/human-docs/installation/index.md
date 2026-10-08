# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Menu Admin per Menu** (`menu_admin_per_menu`) — this is a hard dependency and
  the module builds on it. It in turn pulls in core's **Menu UI** module. Composer
  and Drush handle these automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_perms_per_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Menu Admin per
Menu and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_perms_per_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_perms_per_menu -y
```

Drupal enables **Menu Admin per Menu** (and Menu UI) at the same time as
dependencies.

## Next steps

Nothing changes until you assign permissions to roles. Go to
[Configuration](../configuration/index.md) to grant the per‑menu operations you
want each role to have.
