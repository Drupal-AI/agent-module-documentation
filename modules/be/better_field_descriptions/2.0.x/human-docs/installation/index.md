# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No dependencies and no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_field_descriptions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_field_descriptions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_field_descriptions -y
```

After enabling, head to the settings form to choose which fields get better
descriptions and where the text should appear — see
[Configuration](../configuration/index.md).
