# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other module dependencies and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mojs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mojs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mojs -y
```

## Verify it worked

Once enabled, the mo.js library is registered and available to attach. There is no
settings page to visit — confirm success by attaching the library in your theme or
module and checking that mo.js loads on the page (for example, that the `mojs`
object is available in your browser's JavaScript console on a page where you have
attached it).
