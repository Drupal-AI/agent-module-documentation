# Installation

## Requirements

Font Awesome Block Icons needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The module itself declares no module dependencies.
- **Font Awesome must be available on your site** for the icons to render — for
  example loaded by your theme, or provided by the
  [Font Awesome](https://www.drupal.org/project/fontawesome) module. This module
  adds the per-block icon settings; it does not bundle the icon library itself.

There are no third-party Composer/PHP library requirements from the module.

## Install with Composer

From the project root:

```bash
composer require drupal/fontawesome_block_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fontawesome_block_icons -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fontawesome_block_icons -y
```

## Make sure Font Awesome is loaded

Confirm the Font Awesome icon library is available on your site's pages (via your
theme or the Font Awesome module). Without it, the icon settings will save but the
icons will not display.

## Verify it worked

1. Go to **Structure → Block layout** (`/admin/structure/block`) and click
   **Configure** on any placed block.
2. You should see a **Fontawesome Block Icon** section in the block's
   configuration form.
3. Choose an icon, save, and view a page where the block appears — the icon should
   render alongside the block's title. See
   [Configuration](../configuration/index.md) for the options.
