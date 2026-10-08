# Installation

## Requirements

Starrating is self‑contained and relies only on core:

- **Drupal 10.1.2+ or 11** (`core_version_requirement: ^10.1.2 || ^11`).
- Core's **Field** module (`field`) — the only dependency, and it is enabled by
  default on virtually every site.

There are no third‑party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/starrating -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/starrating -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en starrating -y
```

Enabling the module makes the **Star rating** field type available. Nothing appears
until you add a rating field to a content type — see
[Configuration](../configuration/index.md).
