# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other contrib modules and no third‑party Composer or PHP libraries — it builds
  entirely on Drupal core's AJAX/dialog system.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_dialogs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_dialogs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_dialogs -y
```

When it enables, the bundled Dialog configs for any admin pages you already have
(core plus supported contrib modules) install automatically, so some links will
start opening as dialogs right away. Grant the **Administer dialogs** permission to
the administrators who should curate this, then head to
[Configuration](../configuration/index.md) to add or adjust rules.

There are no submodules.
