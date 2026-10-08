# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Views** module (enabled by default on most sites) — the plugin extends
  Views' access system.

There are no third‑party Composer or PHP library requirements, and no contrib
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/veoa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/veoa -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en veoa -y
```

Once enabled, the **Entity Operation** access option becomes available when you
edit a view's access setting — see [Configuration](../configuration/index.md).

## Submodules

None — VEOA ships as a single module.
