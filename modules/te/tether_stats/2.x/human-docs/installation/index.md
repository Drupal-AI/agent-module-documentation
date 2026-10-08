# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP** (the module lists `php` as a dependency; any PHP version that runs
  your Drupal 10/11 site is fine).
- No other contrib modules or third-party libraries are required — charting is
  built in, unlike the Drupal 7 version which relied on the separate Charts
  module.

## Install with Composer

From the project root:

```bash
composer require drupal/tether_stats -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tether_stats -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tether_stats -y
```

## After enabling

Tether Stats provides its own permissions — review them on the Permissions page
and grant the reporting and administration permissions only to trusted staff
roles, since the collected statistics can be sensitive. Page hits are tracked
automatically once the module is on; to record link clicks and impressions you
add the module's classes to the HTML you want counted.
