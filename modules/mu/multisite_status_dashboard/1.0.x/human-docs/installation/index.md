# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **Drupal core only** — no contributed dependencies and no third‑party
  libraries (it uses Guzzle, which ships with core, plus the key/value, queue,
  and Batch APIs).
- Each site you want to monitor must run the companion **Multisite Status
  Report** module and be reachable over **HTTPS** from this dashboard site.
- Working **cron** on the dashboard site, so background polling runs.

> This is an alpha release (1.0.0‑alpha3) and is marked *not covered* by the
> security advisory policy. Review it before using it on production (see
> [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/multisite_status_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multisite_status_dashboard -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multisite_status_dashboard -y
```

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`):

- **view multisite status dashboard** — lets a role open the aggregated dashboard
  and trigger a refresh. Grant to operators who need the overview.
- **administer multisite status dashboard** — *restricted*; lets a role add,
  edit, and remove monitored sites (which includes their shared secrets). Grant
  to administrators only.

## Verify it worked

Open **Reports → Multisite status** (`/admin/reports/multisite-status`). The
dashboard should load (empty until you add sites). After you add a monitored
site in [Configuration](../configuration/index.md), click **Refresh now** and
confirm a status row appears for it.
