# Installation

## Requirements

Feeds Ical builds on the Feeds module and an external parsing library:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contributed **Feeds** module (`drupal/feeds` `^3.0`) — a hard dependency.
- The **`johngrogg/ics-parser`** PHP library (`^3.4`), which does the actual iCal
  parsing.

Composer installs both the Feeds module and the ics‑parser library for you when you
require Feeds Ical, so there is nothing to download by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_ical -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds and the
ics‑parser library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_ical -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_ical -y
```

Drupal enables the base **Feeds** module as a dependency automatically. There are no
submodules.

## Verify it worked

Go to **Structure → Feed types** (`/admin/structure/feeds`) and add or edit a feed
type. On the **Parser** setting you should now see **Ical Parser** as an option. If
it is there, the module is ready — see [Configuration](../configuration/index.md) to
build your import.
