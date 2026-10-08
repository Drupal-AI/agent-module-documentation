# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no module dependencies. The FullscreenX.js library is loaded
automatically — from a local copy if present, otherwise from the jsDelivr CDN — so
there is nothing you *must* install beyond the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/fullscreen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fullscreen -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fullscreen -y
```

The module loads FullscreenX.js on all pages immediately. No configuration is
required.

## Optional: install the library locally

By default the module falls back to the jsDelivr CDN if the library is not found
locally. If you have a strict Content Security Policy or an offline requirement,
install the library yourself so nothing is fetched from a CDN at runtime. Download
FullscreenX.js (v1.0.0) and place it at:

```
/libraries/FullscreenX/dist/fullscreenx.min.js
```

The module will detect and use the local copy automatically.

## Verify it worked

Load any page and open your browser's developer console. Type `FullscreenX` — it
should resolve to the library's global object rather than `undefined`. From there,
call the API from your own JavaScript as shown in the [main guide](../index.md).
