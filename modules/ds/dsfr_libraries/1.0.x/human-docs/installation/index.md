# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **DSFR distribution** placed at `web/libraries/dsfr/` — the module declares
  libraries from these files but does not ship them itself. The status report
  shows an error until the folder is present.

There are no third‑party PHP library requirements beyond the DSFR asset files.

## Step 1 — Install the DSFR distribution into `libraries/`

The DSFR must live at `web/libraries/dsfr/` (so its built files are under
`web/libraries/dsfr/dist/`). A convenient way is [Asset
Packagist](https://asset-packagist.org). Add the following to your root
`composer.json`, then run `composer update`:

```json
{
    "require": {
        "npm-asset/gouvfr--dsfr": "^1.12"
    },
    "repositories": [
        {
            "type": "composer",
            "url": "https://asset-packagist.org"
        }
    ],
    "extra": {
        "installer-paths": {
            "web/libraries/dsfr": [
                "npm-asset/gouvfr--dsfr"
            ]
        },
        "installer-types": [
            "npm-asset"
        ]
    }
}
```

Alternatively, download the DSFR distribution manually and place it at
`web/libraries/dsfr/`.

## Step 2 — Install this module with Composer

From the project root:

```bash
composer require drupal/dsfr_libraries -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dsfr_libraries -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Step 3 — Enable the module

```bash
drush en dsfr_libraries -y
```

## Verify it worked

Open the **status report** (`/admin/reports/status`) and confirm there is **no**
error about a missing `libraries/dsfr/` folder. Then attach a DSFR library from a
theme or module — for example add `dsfr_libraries/core` to a render array's
`#attached['library']` — and confirm the DSFR CSS/JS loads on the page.

To upgrade the DSFR later, simply swap out the `libraries/dsfr` distribution;
component libraries are re‑registered automatically.
