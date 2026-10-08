# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** (`views`) and **Datetime** (`datetime`) modules, enabled
  automatically as dependencies.
- The FullCalendar JavaScript libraries (and their companions: moment, rrule,
  JSFrame, Popper, and tippy.js themes) — see below.

There are no third-party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fullcalendar_dynamic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fullcalendar_dynamic -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fullcalendar_dynamic -y
```

## Provide the JavaScript libraries

The module expects the calendar libraries under your site's `/libraries`
directory (the FullCalendar core and plugins, moment, rrule, JSFrame, Popper, and
the tippy.js themes). Place a local copy there so the calendar can render. If a
local copy of moment, rrule, or JSFrame is missing, the module can fall back to
their CDN URLs via a library alter — but a local install is the reliable choice.

## Next steps

Nothing appears until you build a calendar View. Follow the **How to use it** steps
on the [overview page](../index.md) to create a View, pick the FullCalendar style,
and map your date fields to the calendar.
