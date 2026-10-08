# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`; the release is tested
  through the current major).
- Drupal core's **Field** module (`field`) — standard on any content site and
  enabled automatically as a dependency.

It uses jQuery (bundled with Drupal) and requires no libraries outside of Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/jstimer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jstimer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jstimer -y
```

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep jstimer
```

Then place or render one of the timer widgets (the live clock or a countdown) and
load the page — the time display should update live in the browser. Double-check
the timezone matches what you expect (see the [overview](../index.md)).
