# Installation

## Requirements

Ajax Loader is core-only:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contrib dependencies and no third-party libraries — the throbber animations
  ship with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ajax_loader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ajax_loader -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ajax_loader -y
```

## Next steps

By default no custom throbber is selected yet (the core throbber is still used).
Head to **Configuration → User interface → Ajax loader** to pick one and save —
see [Configuration](../configuration/index.md). Remember to clear caches after
changing the throbber.
