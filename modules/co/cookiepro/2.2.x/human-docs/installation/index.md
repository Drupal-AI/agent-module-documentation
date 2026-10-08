# Installation

## Requirements

CookiePro by OneTrust is a lightweight integration with no PHP or library
dependencies of its own:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- **A CookiePro / OneTrust account.** This is not a software dependency Composer
  can install — it is the external service that actually provides the consent
  banner, the preference center, and the cookie scanning. Without an account (and
  the `data-domain-script` id it gives you) the module has no script to inject.

There are no other module, Composer, or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cookiepro -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cookiepro -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookiepro -y
```

## After enabling

The module does nothing visible until you paste your OneTrust script into its
settings. Two things to do next:

1. Grant the **CookiePro by OneTrust** permission (`cookiepro_settings`) to the
   roles that should be allowed to manage the consent script, under **People →
   Permissions**. Keep this to trusted administrators — the script is emitted
   into the page head verbatim.
2. Add your consent script on the settings form — see
   [Configuration](../configuration/index.md).
