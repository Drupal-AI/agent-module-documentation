# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A working **BAT** site. This module depends on:
  - **BAT Event** (`bat_event`)
  - **BAT FullCalendar** (`bat_fullcalendar`)
  - **REST UI** (`restui`) — the admin UI for configuring REST resources.
- Core's REST/serialization support (Drupal enables what's needed as
  dependencies).

BAT API is only meaningful on a site already running BAT — install and set up the
BAT stack first.

## Install with Composer

From the project root:

```bash
composer require drupal/bat_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bat_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bat_api -y
```

Enabling the module does not, by itself, expose anything unsafe — but you must now
configure the REST resources and their security deliberately before relying on
them. See [Configuration](../configuration/index.md).
