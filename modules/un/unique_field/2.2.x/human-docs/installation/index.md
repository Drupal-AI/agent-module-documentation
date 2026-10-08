# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No module dependencies and no third-party PHP libraries. It works with core's
  node, taxonomy and user modules, which any standard site already has.

## Install with Composer

From the project root:

```bash
composer require drupal/unique_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/unique_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en unique_field -y
```

## Next steps

Enabling the module changes nothing on its own. Grant the **Administer unique
field settings** permission to the roles that should manage rules, then open a
content type, vocabulary or the Account settings page to define which fields must
be unique — see [Configuration](../configuration/index.md).
