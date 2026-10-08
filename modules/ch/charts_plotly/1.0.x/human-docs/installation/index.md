# Installation

## Requirements

- **Drupal core 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The base **Charts** module (`charts`), version **5.2.1 or higher**, enabled.
- The **Plotly.js** JavaScript library, installed via Asset Packagist (see below).

There are no PHP library requirements.

## Prepare Composer for the Plotly.js library

Plotly.js is brought in through Asset Packagist. Before you require the module,
make sure your project's `composer.json` is set up for it:

1. Add the Asset Packagist repository to the `repositories` section (alongside the
   Drupal packages repository):

   ```json
   "repositories": [
       { "type": "composer", "url": "https://packages.drupal.org/8" },
       { "type": "composer", "url": "https://asset-packagist.org" }
   ]
   ```

2. Install the installers‑extender package, which lets libraries land in
   `/libraries` instead of `/vendor`:

   ```bash
   composer require --prefer-dist oomphinc/composer-installers-extender
   ```

3. Add the installer types and paths to the `extra` section of `composer.json` so
   Composer puts Plotly.js in `web/libraries/plotly.js`:

   ```json
   "extra": {
       "installer-types": ["npm-asset", "bower-asset"],
       "installer-paths": {
           "web/libraries/plotly.js": ["npm-asset/plotly.js-dist-min"],
           "web/libraries/{$name}": [
               "type:drupal-library",
               "type:bower-asset",
               "type:npm-asset"
           ]
       }
   }
   ```

## Install with Composer

With the above in place, require the module:

```bash
composer require drupal/charts_plotly -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_plotly -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charts_plotly -y
```

Then set Plotly as your charting library at
**Configuration → Content authoring → Charts** (`/admin/config/content/charts`).

## Submodules

- **`charts_plotly_api_example`** — an optional example module demonstrating the
  Charts render‑array API with Plotly. Enable it only if you want a working
  reference:

  ```bash
  drush en charts_plotly_api_example -y
  ```

## Verify it worked

Create a View with the **Chart** format (or a chart field) with Plotly selected as
the library, then view it. The chart should render using Plotly.js. If it doesn't
appear, confirm that `web/libraries/plotly.js` exists and clear caches.
