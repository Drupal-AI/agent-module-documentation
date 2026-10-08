# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- The external **js-cookie 3.x** JavaScript library
  (`js-cookie/js-cookie`, `^3.x`). The module works without a local copy — it
  falls back to a jsDelivr CDN version — but for privacy and reliability you'll
  usually want to host it locally (see below).

There are no PHP library requirements and no dependent Drupal modules.

## Install with Composer

From the project root:

```bash
composer require drupal/js_cookie -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/js_cookie -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en js_cookie -y
```

The module ships no submodules and has no configuration to complete.

## Provide the library locally (recommended)

Out of the box the module will load js-cookie from the jsDelivr CDN if it can't
find a local copy — convenient for prototyping, but it sends a request to a third
party and raises a privacy warning on the status report. To serve it yourself,
place the file at:

```
/libraries/js-cookie/dist/js.cookie.min.js
```

You can install it there by hand, with the Composer Merge Plugin, or via Asset
Packagist (`npm-asset/js-cookie`) — see the module's README for the exact steps.

## Verify it worked

Go to **Reports → Status report** (`/admin/reports/status`). The js-cookie check
reports whether the library is being served **locally** or **from the CDN**. If
you placed the file locally, confirm it shows the local copy and the privacy
warning is gone.
