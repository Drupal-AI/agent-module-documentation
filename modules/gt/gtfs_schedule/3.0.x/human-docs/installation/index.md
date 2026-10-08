# Installation

## Requirements

- **Drupal 10.3 or 11** (the 3.0.x package declares core `^10.3 || ^11`).
- **In local mode** — **GTFS Utilities 3.x** installed on the same site to hold
  the feed and expose the REST API the timetable reads.
- **In remote mode** — network access from this site to a **GTFS Utilities REST
  API** running elsewhere. No local GTFS Utilities is needed in this case; the
  module has no hard dependency on it.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/gtfs_schedule
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gtfs_schedule`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gtfs_schedule -y
```

If you are running in local mode, make sure **GTFS Utilities** is installed and its
feed imported as well.

## Verify it worked

Go to **`/admin/gtfs/schedule/settings`** as a user with **Administer GTFS
Schedules**. If the settings form loads, the module is installed. After you connect
it to a GTFS server and set the base path (see
[Configuration](../configuration/index.md)), visit `/<base_url>/<route_id>` for a
real route and confirm the timetable renders.
