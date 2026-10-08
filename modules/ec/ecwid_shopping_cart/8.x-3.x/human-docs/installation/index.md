# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- An **Ecwid account** and store (a free plan is available to try it out).
- Client‑side **JavaScript** in the visitor's browser — the storefront is a JS
  embed, so it needs JS to render.

There are no additional Drupal module dependencies and no PHP library
requirements.

## Install with Composer

From the project root, require the **project** name:

```bash
composer require drupal/ecwid_shopping_cart -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ecwid_shopping_cart -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the **module** machine name, which is `ecwid` (not the project name):

```bash
drush en ecwid -y
```

This is the one thing that trips people up: you `composer require
drupal/ecwid_shopping_cart` but you `drush en ecwid`.

## Verify it worked

Confirm it's on:

```bash
drush pm:list --status=enabled | grep ecwid
```

Then visit `/store` — you'll see the storefront placeholder until you connect a
store. Head to [Configuration](../configuration/index.md) to link your Ecwid
account.
