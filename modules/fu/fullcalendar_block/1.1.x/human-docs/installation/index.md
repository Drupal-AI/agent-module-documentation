# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`) and **PHP
  8.1 or newer**.
- Core's **Block** and **Datetime** modules, both part of a standard install and
  enabled automatically as dependencies.
- The **FullCalendar 5** JavaScript library on the front end. The module loads it
  locally from your site's `/libraries/…` directory if it is present, and otherwise
  falls back to a CDN copy, so a plain install works out of the box; install the
  library locally if you prefer not to depend on a CDN.

## Install with Composer

From the project root:

```bash
composer require drupal/fullcalendar_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fullcalendar_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Optional: install the JS libraries locally

The module suggests the `zodiacmedia/drupal-libraries-installer` Composer plugin,
which makes it easy to install Drupal front-end libraries (FullCalendar, and the
optional `moment`/`rrule` plugins) into your local `/libraries` directory. This is
optional — without it the module uses a CDN fallback.

## Enable the module

```bash
drush en fullcalendar_block -y
```

You can also enable it from **Extend** (`/admin/modules`).

## What happens next

Nothing appears until you place the block. Go to the [overview](../index.md#how-to-use-it)
for how to prepare an event feed and place and configure the **FullCalendar block**
from Block layout.
