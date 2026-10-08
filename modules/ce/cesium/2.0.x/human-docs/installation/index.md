# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- [Geofield](https://www.drupal.org/project/geofield) (`geofield`) — provides the
  field the Cesium Globe formatter renders.
- The **CesiumJS library** itself, present at
  `web/libraries/cesium/Build/Cesium/Cesium.js` (see below).

This is an **alpha** release (`2.0.0-alpha1`) — test before production use.

## Install via Composer (recommended)

The module is small; the library is the part that needs care. CesiumJS is provided
by the `npm-asset/cesium` package through Asset Packagist, and because Composer
does not inherit repository definitions from contributed modules, you configure
your **project's root `composer.json`** to fetch and place it.

**Step 1 — add the Asset Packagist repository** to your root `composer.json`:

```json
{
  "repositories": [
    { "type": "composer", "url": "https://asset-packagist.org" }
  ]
}
```

**Step 2 — install the installer that handles npm assets:**

```bash
composer require oomphinc/composer-installers-extender
```

Then add to your root `composer.json` so npm assets land in `web/libraries/`:

```json
{
  "extra": {
    "installer-types": ["npm-asset"],
    "installer-paths": {
      "web/libraries/{$name}": ["type:npm-asset"]
    }
  }
}
```

**Step 3 — require the module:**

```bash
composer require drupal/cesium
```

Composer now fetches `drupal/cesium` from packages.drupal.org, pulls
`npm-asset/cesium` from Asset Packagist, and extracts the library to
`web/libraries/cesium`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cesium`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Manual installation (alternative)

1. Download and extract the Cesium module to `web/modules/custom/cesium`.
2. Download the CesiumJS library and place it at `web/libraries/cesium/`.
3. Enable the module at **Extend** (`/admin/modules`).

## Enable the module

```bash
drush en cesium -y
```

Drupal enables Geofield at the same time as a dependency.

## Verify it worked

Confirm the module and Geofield are enabled under **Extend**. Then check the
library resolves by visiting the settings form at
`/admin/config/services/cesium` and configuring a Geofield to use the **Cesium
Globe** formatter (see [Configuration](../configuration/index.md)); the globe
should render on content. If it doesn't, re-check that CesiumJS is present under
`web/libraries/cesium/`.
