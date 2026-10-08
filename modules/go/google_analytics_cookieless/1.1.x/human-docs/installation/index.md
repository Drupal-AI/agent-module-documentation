# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **FingerprintJS** JavaScript library (`fingerprintjs2`, version 2.x) — the
  module uses it to generate a client identifier in place of the GA cookie. This is
  an external library you must add yourself.
- A **Universal Analytics** property ID (`UA-XXXXXXX-Y`). Note that Universal
  Analytics has been sunset by Google — see the caution on the
  [overview page](../index.md).

## Install with Composer

Install the module from the project root:

```bash
composer require drupal/google_analytics_cookieless -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

### Add the FingerprintJS library

The library is not on Packagist by default. Add a package repository for it in your
`composer.json` and then require it (the module's project page documents the
`valve/fingerprintjs2` package definition), or download it manually and place
`fingerprint2.js` under `libraries/fingerprintjs/`. The file should end up at:

```
libraries/fingerprintjs/fingerprint2.js
```

FingerprintJS does not ship a minified build. The simplest way to get one is to
turn on **JavaScript aggregation** at **Configuration → Development → Performance**
(`/admin/config/development/performance`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_analytics_cookieless -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_analytics_cookieless -y
```

## Verify it worked

Go to **Configuration → System → Google Analytics Cookieless**
(`/admin/config/system/google-analytics-cookieless`) and confirm the settings form
loads. Enter a valid `UA-…` account ID (see
[Configuration](../configuration/index.md)), then load a front-end page and confirm
the analytics snippet is present and that no `_ga` cookie is set.
