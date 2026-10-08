# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Paragraphs** (`paragraphs`), **Media** (`media`), **Media Library**
  (`media_library`) — core/contrib modules used to model each amenity.
- **Blazy** (`blazy`) — lazy-loads the amenity icons.
- **Y Layout Builder** (`y_lb`) — the YMCA Website Services Layout Builder
  package. This is the critical dependency; read the note below before you start.

This module is meant to be used **with the YMCA's Website Services
distribution**, not on a plain Drupal site.

## A note about the `y_lb` dependency

`lb_branch_amenities_blocks` requires `y_lb` with **no version constraint**. The
copy of `ycloudyusa/y_lb` published on Packagist is an old **0.1 stub from 2022**
that only supports Drupal 8 and 9, so on a modern site Composer may quietly
accept that stub and the module then fails at *enable* time with a message like:

```
Unable to install modules: Its dependency module 'y_lb' is incompatible with
this version of Drupal core.
```

The current, supported `y_lb` (3.x, 4.x, 5.x) lives in the **YMCA's own Composer
repository**, not on Packagist. The fix is to add that repository to your
project before requiring anything in this family — which happens automatically
when you build on the YMCA Website Services distribution.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_branch_amenities_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed. Make sure the YMCA Composer repository is configured
first so a real `y_lb` is resolved.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lb_branch_amenities_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_branch_amenities_blocks -y
```

## Verify it worked

Edit a Branch page's Layout Builder layout and confirm the **Branch Amenities**
block appears in the "Add block" list. If enabling fails with a `y_lb`
incompatibility message, revisit the dependency note above — the YMCA Composer
repository is almost certainly missing.
