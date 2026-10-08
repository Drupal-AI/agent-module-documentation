# Installation

## Requirements

- **Drupal 10.3+ or Drupal 11** (`core_version_requirement: ^10.3||^11`).
- No additional Drupal modules are required.
- The JavaScript libraries the card relies on (Tippy.js and its Popper.js
  positioning engine) are loaded automatically — you don't install them yourself.

There are no third‑party Composer or PHP library requirements to add.

## Install with Composer

From the project root:

```bash
composer require drupal/hover_card -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hover_card -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hover_card -y
```

## Clear caches

After enabling, clear caches so the new library and template are picked up:

```bash
drush cr
```

## Verify it worked

Grant the **View hover cards** permission (see
[Configuration](../configuration/index.md)), then visit a page that links to a
user — for example a piece of content showing its author. Hovering over the
author's name should pop up the hover card. If nothing appears, check that the
permission is granted and that your theme's user links match the module's CSS
selector (also covered in Configuration).

## Upgrading from 1.x

Version 2.0 is a complete rewrite and includes **breaking changes** — notably the
CSS class names changed (the old `.hover-card-user-*` classes were renamed). If you
had custom styling for Hover Card 1.x, review the new BEM class names in
[Configuration](../configuration/index.md) and update your theme overrides
accordingly.
