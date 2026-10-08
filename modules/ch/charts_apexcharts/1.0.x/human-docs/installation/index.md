# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **Charts** module, **version 5.2.1 or higher** (`charts:charts`).
- The **ApexCharts** JavaScript library (`npm-asset/apexcharts`), which is served
  from **Asset Packagist** — see the one‑time Composer setup below.
- ApexCharts itself is MIT licensed and free for commercial use.

If you don't already have data on your site to chart, modules such as Charts AI
Agents, Views CSV Source, Views JSON Source, Views Database Connector, External
Entities, and Views Fields On/Off are useful companions.

## One‑time Composer setup for Asset Packagist

The ApexCharts library is **not** on `packages.drupal.org`, so a plain
`composer require` will fail with a misleading *"could not be found in any version,
there may be a typo"* error. Before requiring the module, make sure your project's
`composer.json` is set up to install front‑end libraries from Asset Packagist:

1. Add the Asset Packagist repository to the `repositories` section:

   ```json
   "repositories": [
       { "type": "composer", "url": "https://packages.drupal.org/8" },
       { "type": "composer", "url": "https://asset-packagist.org" }
   ]
   ```

2. Install the installers‑extender package so libraries land in `/libraries`
   rather than `/vendor`:

   ```bash
   composer require --prefer-dist oomphinc/composer-installers-extender
   ```

3. Make sure the installer types and paths are declared in the `extra` section so
   ApexCharts installs into `web/libraries/apexcharts`:

   ```json
   "extra": {
       "installer-types": ["npm-asset", "bower-asset"],
       "installer-paths": {
           "web/libraries/{$name}": [
               "type:drupal-library",
               "type:bower-asset",
               "type:npm-asset"
           ]
       }
   }
   ```

## Install with Composer

With the above in place, from the project root:

```bash
composer require drupal/charts_apexcharts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Charts
dependency and the ApexCharts library and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_apexcharts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charts_apexcharts -y
```

## Select ApexCharts as your charting library

1. Go to **Configuration → Content authoring → Charts**
   (`/admin/config/content/charts`).
2. Set **ApexCharts** as your default charting library and save.

## Verify it worked

Build a quick chart to confirm rendering — for example, create a View and choose
the **Chart** format, or add a **Chart** field to an entity type. With ApexCharts
selected as the library, the chart should render using ApexCharts. If instead the
site reports the library is missing, revisit the Asset Packagist setup above and
confirm the files landed in `web/libraries/apexcharts`.
