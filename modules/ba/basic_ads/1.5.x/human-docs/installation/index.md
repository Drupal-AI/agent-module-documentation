# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`; the module's
  own metadata also lists Drupal 12).
- Core modules that Drupal will enable as dependencies: **Node**, **Taxonomy**,
  **Datetime**, **Image**, **Text**, **Link**, **Views** and **Block**.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/basic_ads -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/basic_ads -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en basic_ads -y
```

Drupal turns on the core dependencies (Node, Views, Block and the rest)
automatically. After this, grant the Basic Ads permission to the trusted editors
who should manage ads, then start creating ads and placements — see
[How to use it](../index.md#how-to-use-it).
