# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Datetime** and **User** modules (both standard in Drupal).
- The **[Chosen](https://www.drupal.org/project/chosen)** module, which provides
  the searchable-dropdown enhancement for the city selector.

There are no PHP library requirements — the GeoNames city data ships with the
module.

> **Note:** this module is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/city_timezones -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Chosen
dependency alongside City Timezones.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/city_timezones -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en city_timezones -y
```

Drupal will enable the Chosen dependency automatically if it isn't already on.

## Verify it worked

Go to your account edit form (or the user registration form) and scroll to the
timezone section. Above the standard timezone dropdown you should now see a
**city** selector. Search for a well-known city and confirm the IANA timezone field
below it updates to match. To adjust which cities appear, see
[Configuration](../configuration/index.md).
