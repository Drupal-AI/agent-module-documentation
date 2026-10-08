# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contrib modules are required for the two built-in styles.
- The two shipped styles — **Simple expanding** and **Mean Menu** — work with no
  external libraries. The additional styles (Sidr, codrops Multi-level, Google
  Nexus, Multi-level Push Menu) each need their JavaScript library downloaded
  separately before you can use them.
- No Composer library or PHP-version requirements beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_menus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_menus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_menus -y
```

There are no submodules. Once enabled, head to
[Configuration](../configuration/index.md) to choose a style and point the module
at the menu you want to make mobile-friendly — nothing happens until you set a
selector.
