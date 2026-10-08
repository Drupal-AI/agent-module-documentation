# Installation

## Requirements

RefreshLess needs:

- **Drupal 10.5 or 11.2** (`core_version_requirement: ^10.5 || ^11.2`).
- **PHP 8.2** or newer.
- The **Hux** module (`hux`) — its one dependency, installed automatically with
  Composer.
- Core's **BigPipe** module enabled is strongly recommended — RefreshLess
  cooperates with it, and the module's install requirements warn if it's missing.

> **Note:** version 2.0.x is currently an alpha release. Test it on a non-production
> environment before rolling it out.

## Install with Composer

From the project root:

```bash
composer require drupal/refreshless -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the required Hux module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/refreshless -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en refreshless -y
```

This also enables **Hux** if it isn't already. Confirm **BigPipe** is enabled too
(`drush en big_pipe -y` if needed).

## Verify it worked

Browse the site as a visitor and click between pages. Navigation should swap the
content in place — faster and without the full page flash — rather than doing a
complete reload. If you have JavaScript disabled, the site should still work
normally with traditional page loads. See the parent
[guide](../index.md#how-to-use-it) for more.
