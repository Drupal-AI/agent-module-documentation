# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The external **instafeed.js** JavaScript library (version 2.0.0), installed into
  your site's `libraries` folder with the correct name.
- An **Instagram access token** — which in turn means a Facebook app and an
  Instagram business or creator account. Follow Instagram's own guide to obtain
  the token.

## Install with Composer

From the project root:

```bash
composer require drupal/instafeed_block -W
```

The instafeed.js library is not on Packagist by default, so register it as a
Composer package and require it. From the project root:

```bash
composer config repositories.instafeedjs '{"type": "package", "package": {"name": "stevenschobert/instafeed.js", "version": "2.0.0", "type": "drupal-library", "dist": {"url": "https://github.com/stevenschobert/instafeed.js/archive/refs/tags/v2.0.0.zip", "type": "zip"}}}'
composer require stevenschobert/instafeed.js:2.0.0
```

This places the library at `/libraries/instafeed.js`. (If you are upgrading from
an older release that expected `/libraries/instafeed-js`, note the folder name
changed to `/libraries/instafeed.js`.) You can also download the library manually
into the `libraries` folder if you prefer.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instafeed_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instafeed_block -y
```

## Verify it worked

Go to **Reports → Status report** (`/admin/reports/status`) and confirm the
instafeed.js library is detected — the module checks for it there. If the status
report reports the library missing, re-check that it is installed at
`/libraries/instafeed.js` with exactly that name.

Once the library is in place, continue to [Configuration](../configuration/index.md)
to add your access token and create a block.
