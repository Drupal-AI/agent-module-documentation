# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- jQuery (core's `core/jquery`), which the library declares as a dependency.

There are no other module dependencies and no PHP requirements. The FullCalendar
JavaScript files themselves are optional to download — without them the module
serves the assets from a CDN (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/fullcalendar_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fullcalendar_library -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fullcalendar_library -y
```

Once enabled, the two asset libraries are available to attach. Nothing else is
required — with no local files present, the calendar loads from the jsDelivr CDN.

## Optional — self‑host the library files

To serve the assets locally instead of from the CDN, download FullCalendar **v3**
from <https://fullcalendar.io/download/> (and the Scheduler add‑on if you need it)
and place the files under your web root:

```
/libraries/fullcalendar/lib/moment.min.js
/libraries/fullcalendar/fullcalendar.min.js
/libraries/fullcalendar/locale-all.js
/libraries/fullcalendar/fullcalendar.min.css
/libraries/fullcalendar/fullcalendar.print.min.css
/libraries/fullcalendar-scheduler/scheduler.min.js
/libraries/fullcalendar-scheduler/scheduler.min.css
```

The fallback works file by file, so a partial local install uses local copies for
the files that are present and the CDN for the rest. Run `drush cr` after adding or
removing files, because library definitions are cached. Confirm the active source
on **Reports → Status report** (`/admin/reports/status`).

## Submodules

Fullcalendar library ships no submodules.
