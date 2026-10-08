# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: ^8.1`).
- Core's **Config** module (`config`).
- The contrib **Update Helper** module (`drupal/update_helper`, `^2 || ^3 || ^4`)
  — Composer pulls this in automatically when you require the module below, and
  Drupal enables it as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/config_modify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, and it's what pulls in the `drupal/update_helper`
dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_modify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_modify -y
```

> **Note:** when Config Modify is first enabled, any `config/modify` files that
> already exist on the site are marked as *applied* without running, to avoid
> race conditions with update hooks. So enabling the module won't retroactively
> apply pre‑existing modification files — it takes effect for modifications added
> from then on.

Next, see [Configuration](../configuration/index.md) for how to write a
`config/modify` file and the Drush commands.
