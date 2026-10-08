# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies and no third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_field_capitalization -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_field_capitalization -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_field_capitalization -y
```

## Verify it worked

Go to **Configuration → Entity Field Capitalization settings**
(`/admin/config/field-capitalization-settings`) and confirm the settings form
loads. Nothing is capitalized until you list the fields there — head to
[Configuration](../configuration/index.md) to set that up.
