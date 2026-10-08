# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **js_cookie** module (`js_cookie`), which provides the cookie storage used to
  remember each visitor's open/closed choices. Composer/Drupal pull it in as a
  dependency.

The slide animation library is bundled with the module, so there is no separate
JavaScript library to download.

## Install with Composer

From the project root:

```bash
composer require drupal/collapsiblock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
including `js_cookie`, as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/collapsiblock -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en collapsiblock -y
```

## Verify it worked

Go to **Structure → Block layout**, configure a block, and set its Collapsiblock
default state (see "How to use it" on the [overview page](../index.md)). Then view a
page containing that block — clicking the block title should slide its content open
and closed.
