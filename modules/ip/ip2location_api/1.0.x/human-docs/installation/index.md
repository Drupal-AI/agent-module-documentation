# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Key](https://www.drupal.org/project/key)** module (`key`) — a hard
  dependency, used to store your API key securely.
- An **IP2Location.io API key**, obtained by signing up at
  [ip2location.com](https://www.ip2location.com).
- Under the hood the module uses the `ip2location/ip2location-io-php` PHP library;
  requiring the module with Composer brings in what it needs.

## Install with Composer

Requiring the module with the `-W` flag pulls in the Key module and the PHP
library as dependencies:

```bash
composer require drupal/ip2location_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ip2location_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ip2location_api -y
```

Drupal enables the Key module automatically as a dependency.

## Verify it worked

After you complete the [Configuration](../configuration/index.md) steps (create a
Key and select it), inject the service into a small piece of custom code and call
`getCountryName()` — a valid country name for the current request confirms the
key and connection work.

> **Heads up:** this release is an early alpha (1.0.0‑alpha1) and is not covered
> by Drupal's security advisory policy. Test it before relying on it in
> production.
