# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Datetime** module (`datetime`) — the only dependency, enabled
  automatically.

No third‑party Composer or PHP libraries are required; the Persian date-picker and
the calendar implementations ship inside the module.

## Install with Composer

From the project root:

```bash
composer require drupal/calendar_systems -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calendar_systems -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calendar_systems -y
```

Because the module replaces core's `date.formatter` service, clear caches after
enabling so Drupal rebuilds the service container:

```bash
drush cr
```

From this point, site dates localize automatically according to the interface
language — see [Configuration](../configuration/index.md).

## Submodules — enable only what you need

Two optional submodules extend Calendar Systems. Enable them individually:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Calendar Systems: Better Exposed Filters** | `calendar_systems_bef` | Turns a Views exposed date filter into a Jalali date-picker (requires the Better Exposed Filters module). |
| **Calendar Systems: FullCalendar** | `calendar_systems_fullcalendar` | Renders a Jalali FullCalendar (requires the FullCalendar module). |

For example:

```bash
drush en calendar_systems_fullcalendar -y
```

Each submodule requires the base Calendar Systems module, which is already present
once installed above.
