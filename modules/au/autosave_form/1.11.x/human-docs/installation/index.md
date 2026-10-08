# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **System** module (`system`), which is always enabled.
- No third‑party Composer or PHP library requirements, and no contrib
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/autosave_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autosave_form -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autosave_form -y
```

Once enabled, autosave is active on content entity forms straight away with the
default 60‑second interval. There are **no submodules**.

## Next steps

To change the interval, choose which entity types and bundles are covered, or tune
the notification, see [Configuration](../configuration/index.md).
