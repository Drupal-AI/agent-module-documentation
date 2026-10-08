# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other Drupal module dependencies. The module bundles the Anime.js JavaScript
  library.

## Install with Composer

From the project root:

```bash
composer require drupal/anime -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/anime -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en anime -y
```

Enabling the module makes the Anime.js library available to other modules and themes.
There is nothing to configure — see [How to use it](../index.md#how-to-use-it) in the
overview for depending on the library from your own code.
