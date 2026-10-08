# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies and no third-party PHP libraries. It works against core's
  user login and password routes, which every site has.

## Install with Composer

From the project root:

```bash
composer require drupal/remove_reset_password -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remove_reset_password -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remove_reset_password -y
```

## Next steps

Enabling the module changes nothing until you tick a box on its settings form. Go to
**Configuration → People → Remove Reset password** to choose what to hide or block —
see [Configuration](../configuration/index.md).
