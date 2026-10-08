# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **iframe-resizer 4.x** JavaScript library, installed separately (see below).
  This is required — the module is only the Drupal wiring around it.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/iframe_resizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/iframe_resizer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Install the iframe-resizer library (required)

The iframe-resizer JavaScript library is **not** shipped with the module. Install
version 4.x so that it lands in `libraries/iframe-resizer/`:

```bash
composer require bower-asset/iframe-resizer:^4
```

> **Important:** stay on the **4.x** series. Version 5.x is a commercial release and
> is **not supported** by this module.
>
> Installing `bower-asset/*` packages usually requires the
> `oomphinc/composer-installers-extender` (or `asset-packagist`) setup in your
> project's `composer.json`. If Composer cannot find the package, add the
> asset-packagist repository first.

Until the file `libraries/iframe-resizer/js/iframeResizer.min.js` exists, the site's
**Reports → Status report** shows an error for iFrame Resizer.

## Enable the module

```bash
drush en iframe_resizer -y
```

Once both the module and the library are in place, open the settings form and enable
host and/or hosted mode — see [Configuration](../configuration/index.md). The module
does nothing until at least one mode is turned on.
