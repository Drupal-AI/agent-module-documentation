# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.3 or newer**.
- **MySQL 5.7+ or MariaDB 10.3+.** SQLite and PostgreSQL are **not** supported —
  the module uses `GROUP_CONCAT` to aggregate the services at each stop.
- The following contrib modules, all declared in the module's `.info.yml` and
  enabled automatically when you install via Composer with `-W`:
  - `drupal/migrate_plus` (^6.0)
  - `drupal/migrate_source_csv` (^3.0)
  - `drupal/geofield` (^1.0, including the `geofield` submodule)
  - `drupal/leaflet` (^10.0, including the `leaflet_views` and
    `leaflet_markercluster` submodules)
  - Core `migrate` and `views` (plus `datetime`, `file`, and `system`).

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_bus_data -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch the contrib
dependencies above and update any shared ones as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_bus_data -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_bus_data -y
drush cr
```

If you are upgrading from 1.3.x, run the database updates as well —
`drush updatedb -y` then `drush cr`. The updates backfill the new route **slug**
segment from data already on the site (no reimport), and adjust the timetable
Views configuration. **If you deploy configuration from a repository, run
`drush config:export` and commit the result afterwards**, or the next
`drush config:import` will revert the timetable view's path back to two segments.

## Submodules

### LocalGov Bus Data Homepage (`localgov_bus_data_homepage`)

An optional submodule that provides a public‑facing landing page at **`/buses`**
with configurable intro text, a route‑number search form, an operator search form
(with autocomplete on bus company names), a stop‑name search form, interchange and
bus‑station quick‑links, and an area‑browse widget (localities grouped by a
configurable area, driven by NaPTAN locality data).

> The interchange links and area‑browse sections rely on `bustimes_locality`
> data, which is only populated **after NaPTAN enrichment runs**. Enable and
> configure NaPTAN in the main settings *before* enabling this submodule.

```bash
drush en localgov_bus_data_homepage -y
```

Configure it at `/admin/config/localgov-bus-data/homepage`.

## Verify it worked

After enabling the module, open **`/admin/config/localgov-bus-data/settings`** —
the settings form should load. Nothing will import until you configure a feed URL
and enable imports (see [Configuration](../configuration/index.md)); once an
import has run — or after `drush bus-times:seed` inserts development fixtures —
the visitor pages at `/buses/routes`, `/buses/stops`, and `/buses/map` will start
showing data.
