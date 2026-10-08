# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3 || ^12`).
- **Admin Toolbar** (`admin_toolbar`) and **Honeypot** (`honeypot`) — both are
  contrib modules and are pulled in automatically when you install with Composer.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/labor_time_tracker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Admin Toolbar and
Honeypot and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/labor_time_tracker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en labor_time_tracker -y
```

Drupal will enable Admin Toolbar and Honeypot at the same time if they aren't
already on.

## Assign permissions

Go to **People → Permissions** and decide who gets:

- **administer labor time tracker** — managers who configure daily hours, manage
  logs, approve or reject change requests, and read the report.
- **view labor times** — anyone allowed to view recorded times.

Remember that attendance data is personal; grant these permissions narrowly.

## Verify it worked

Log in as a collaborator and visit **`/labor-info/time-log`** — you should see the
clock‑in/clock‑out action button. As a manager, visit
**`/admin/config/labor-time/settings`** to confirm the admin pages are available.
