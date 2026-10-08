# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- Core's **Node**, **Views**, and **Field** modules (`node`, `views`, `field`) — all
  standard in a Drupal install and enabled automatically as dependencies.
- **Font Awesome 4** (for the calendar-platform icons) and **jQuery** (ensure it is
  available through your theme or core libraries) for the front-end display.

This project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/event_to_calendar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/event_to_calendar -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en event_to_calendar -y
```

## Verify it worked

Log in as an administrator and open **/admin/config/event-to-calendar**. If the
settings form appears and lists your content types, the module is installed. Continue
to [Configuration](../configuration/index.md) to enable your event content types and
map their fields.
