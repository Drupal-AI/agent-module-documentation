# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **jQuery Sidr** JavaScript/CSS library, installed separately (see below) — the
  module integrates it but does not ship it.

There are no PHP dependencies beyond core.

## Install the module with Composer

From the project root:

```bash
composer require drupal/sidr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sidr -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Install the jQuery Sidr library (required)

The slide behavior comes from the third‑party jQuery Sidr library, which must end up
at `libraries/jquery.sidr/dist/jquery.sidr.min.js`. The module ships a
`composer.libraries.json` referencing the `jquery/sidr` package (2.2.1, from Asset
Packagist). The easiest way to pull it in is with the **Composer Merge Plugin**,
which the module suggests:

1. Require the merge plugin and make sure Asset Packagist is a configured repository
   in your project's `composer.json`.
2. Merge the module's `composer.libraries.json` and add a `type:drupal-library`
   installer path so the library lands under `libraries/`.
3. Run `composer update` so the library is downloaded.

After installing, check **Reports → Status report** — it reports whether the jQuery
Sidr library was found. If it isn't found, the trigger button will render but nothing
will slide.

## Enable the module

```bash
drush en sidr -y
```

## Next step

Head to [Configuration](../configuration/index.md) to set the global options and
place your first Sidr trigger block.
