# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.3 or newer**.
- Drupal core only — there are no contrib module dependencies.

By default the highlight.js assets are loaded from the unpkg.com CDN, so there is
nothing extra to install to get started. If you want to **self-host** the assets, the
following Composer packages help (all optional, suggested by the module):

- `highlightjs/cdn-assets` — the pre-built highlight.js assets, managed locally.
- `npm-asset/highlightjs-copy` — the copy-to-clipboard plugin, via Asset Packagist.
- `oomphinc/composer-installers-extender` — needed to place `npm-asset` packages via
  `installer-paths`.

## Install with Composer

From the project root:

```bash
composer require drupal/highlightjs_input_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/highlightjs_input_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en highlightjs_input_filter -y
```

There are no submodules. After enabling, turn the filter on for a text format and
adjust the settings — see [the overview](../index.md#how-to-use-it) for the
step-by-step.
