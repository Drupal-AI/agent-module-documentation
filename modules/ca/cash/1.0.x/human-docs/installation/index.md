# Installation

## Requirements

- **Drupal 8.8 or newer** (`core_version_requirement: >=8.8`).
- The **Cash JavaScript library** itself, placed in your site's `libraries/`
  directory (see below). There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/cash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cash -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Place the Cash library

The module wraps a library it does not bundle, so you need the Cash files on
disk. The module looks in two supported locations:

- `/libraries/cash/dist/cash.min.js` — if you download Cash from GitHub, extract
  it, and rename the `cash-master` folder to `cash`.
- `/libraries/cash-dom/dist/cash.min.js` — if you pull it in as an npm/asset
  package via Composer (Asset Packagist / `npm-asset`).

Any path recognized by Drupal's core library finder (or the Libraries module)
also works.

## Enable the module

```bash
drush en cash -y
```

## Verify it worked

Enabling the module does not, by itself, put Cash on any page — it only registers
the `cash/cash` asset library. To confirm the library resolves, either attach it
from your own library/theme (see the main [guide](../index.md)) or turn on
site-wide loading from the [Configuration](../configuration/index.md) form, then
load a page and check that `cash.min.js` appears in the page source.
