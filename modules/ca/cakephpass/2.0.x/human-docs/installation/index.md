# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other module dependencies and no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/cakephpass -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cakephpass -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cakephpass -y
```

Enabling the module registers its service provider, which swaps the core
`password` service for CakePhPass's version. On its own that changes nothing —
verification stays off until you add the settings block described in
[Configuration](../configuration/index.md).

## Next step

Add the `settings.php` block covered in [Configuration](../configuration/index.md)
to switch verification on and supply your CakePHP salt and hash type.
