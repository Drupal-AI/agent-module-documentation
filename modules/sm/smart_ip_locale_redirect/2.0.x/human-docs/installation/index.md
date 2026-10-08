# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- These modules, all hard dependencies:
  - **Smart IP** (`smart_ip`) — provides the IP-to-country geolocation. It needs
    its own data source configured (a GeoIP database or a web service such as the
    MaxMind GeoIP2 Precision submodule).
  - **Redirect** (`redirect`) — its redirect-loop protection complements this
    module.
  - **Locale** (`locale`) and **Path alias** (`path_alias`) — core modules used to
    resolve languages and translate path aliases into the target language.

There are no third-party PHP library requirements for this module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_ip_locale_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Smart IP, Redirect,
and the other dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_ip_locale_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_ip_locale_redirect -y
```

Drush enables the dependency modules automatically.

## Set up permissions

Grant the **access smart IP locale redirect settings** permission to the roles
that should manage the module, at **Administration → People → Permissions**
(`/admin/people/permissions#module-smart_ip_locale_redirect`). This is what gates
the settings form.

## Next step

Enabling the module is not enough on its own — you must configure the Smart IP data
source and the country-to-language mapping. Continue to
[Configuration](../configuration/index.md).
