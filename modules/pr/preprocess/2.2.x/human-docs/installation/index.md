# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.1 or newer** (`^7.1 || ^8`).

There are no other module dependencies and no third-party Composer library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/preprocess -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/preprocess -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en preprocess -y
```

## Next step

There is nothing to configure. The module does nothing on its own until you provide
Preprocess plugins in your own modules or themes — see
[How to use it](../index.md#how-to-use-it). Remember to rebuild caches (`drush cr`)
after adding or changing a plugin so it's discovered.
