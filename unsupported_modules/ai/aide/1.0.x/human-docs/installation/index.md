# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).

Aide has no other modules, PHP libraries, or external services as dependencies —
it is a self‑contained helper library.

## Install with Composer

From the project root:

```bash
composer require drupal/aide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aide -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aide -y
```

That's all — enabling the module makes the `Drupal\aide\Aide` class autoloadable.
There is no configuration.
