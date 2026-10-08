# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The third-party **garand/sticky** JavaScript library, installed at
  `/libraries/sticky/jquery.sticky.js` (see below). The module does **not** bundle
  it, and won't work without it.

There are no other Drupal module dependencies and no Composer PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sticky -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sticky -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sticky -y
```

## Download the JavaScript library (required)

The actual "stick on scroll" behavior is delivered by the **garand/sticky** jQuery
plugin, which you must download and place yourself:

1. Get the library from <https://github.com/garand/sticky>.
2. Place its `jquery.sticky.js` file so it lives at
   `/libraries/sticky/jquery.sticky.js` under your Drupal web root (i.e. a
   `libraries/sticky/` directory containing `jquery.sticky.js`).

Without this file, the module attaches nothing usable and no element will stick.

## Verify it worked

Go to **Configuration → System → Sticky** (`/admin/config/system/sticky`) — the
settings form should load. Set the **DOM Selector** to an element that exists on
your pages, save, then scroll a page containing that element: it should stay
visible. If it doesn't, re-check that the library file is at
`/libraries/sticky/jquery.sticky.js` and that your selector matches the rendered
markup. Then see [Configuration](../configuration/index.md) to fine-tune spacing,
classes, and width.
