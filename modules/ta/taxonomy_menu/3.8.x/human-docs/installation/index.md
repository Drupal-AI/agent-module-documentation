# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`), which is enabled automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_menu -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_menu -y
```

Once enabled, go to **Structure → Taxonomy menu** to create your first
vocabulary‑to‑menu mapping — see [Configuration](../configuration/index.md).
