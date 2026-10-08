# Installation

## Requirements

- **PHP 8.3 or newer** (`php: ^8.3`).
- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Datetime Range** (`datetime_range`) and **Options** (`options`) modules —
  enabled automatically as dependencies.
- The contrib **[Field Inheritance](https://www.drupal.org/project/field_inheritance)**
  module, version **3.x** (`drupal/field_inheritance: ^3`) — this is what lets each
  event instance inherit field values from its series, so it is required.

Optional but suggested:

- **[Token](https://www.drupal.org/project/token)** — token support.
- **[Group](https://www.drupal.org/project/group)** — group integration.
- **[Full Calendar View](https://www.drupal.org/project/fullcalendar_view)** — a
  calendar display of your events.
- **[Date Range Compact](https://www.drupal.org/project/daterange_compact)** —
  compact date-range formatting.

## Install with Composer

From the project root — Composer resolves Field Inheritance and the other
dependencies for you:

```bash
composer require drupal/recurring_events -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recurring_events -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recurring_events -y
```

## Submodules — enable only what you need

Recurring Events ships several optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Registration** | `recurring_events_registration` | Visitor registration for event instances, with capacity limits, waitlists, and notifications (adds a Registrant entity). |
| **Reminders** | `recurring_events_reminders` | Reminder emails ahead of upcoming events. Nested under Registration. |
| **iCal** | `recurring_events_ical` | Export a series or instance as an iCalendar (`.ics`) file, with property mapping. |
| **Views** | `recurring_events_views` | Swaps the default series/instance list builders for Views-powered overviews. |

For example, to let visitors register for events:

```bash
drush en recurring_events_registration -y
```

Each submodule requires the base Recurring Events module, which is already present
once you have installed it above.

## Next steps

Head to [Configuration](../configuration/index.md) to review the series and instance
settings, grant the permissions your editors need, and create your first event
series.
