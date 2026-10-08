# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- The PHP library **`justinrainbow/json-schema`** (`^5.2 || ^6.6`), used to
  validate the JSON options you enter. Composer installs it automatically.
- The **Choices.js** JavaScript library itself — either self-hosted or loaded
  from a CDN (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/choices -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install
`justinrainbow/json-schema` and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/choices -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Provide the Choices.js library

The module needs the front-end Choices.js library available. You have two options:

- **Self-host (recommended for production)** — place the library at
  `/libraries/choices.js/` so its assets exist at
  `/libraries/choices.js/public/assets/scripts/choices.min.js` (and the matching
  CSS). You can do this by requiring the asset package
  `bower-asset/choices.js` via Composer (this needs the asset-packagist
  repository configured) or by downloading the library manually.
- **Use the CDN** — skip local hosting and simply tick **Use CDN** on the settings
  page, which loads the library from jsDelivr instead. Handy for quick trials, but
  it adds an external dependency.

## Enable the module

```bash
drush en choices -y
```

To also enable the Facets integration submodule:

```bash
drush en choices_facets -y
```

(The `choices_facets` submodule requires the Facets module and is documented in
its own tree.)

Once enabled, head to [Configuration](../configuration/index.md) to turn on global
mode, choose the CDN option, or set up the field widget.
