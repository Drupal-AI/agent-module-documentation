# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- Core's **System** (`system`) and **User** (`user`) modules — always present on a
  Drupal site.
- No third‑party Composer packages or PHP libraries.
- A working **cron** setup, since automatic checks run on cron.

## Install with Composer

From the project root:

```bash
composer require drupal/disk_space_alert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disk_space_alert -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disk_space_alert -y
```

## Make sure cron runs

The module performs its automatic disk checks during cron runs. Confirm cron is
scheduled to run regularly (Drupal's built‑in cron, a system crontab, or
`drush cron`). How often cron runs also sets how often you could be alerted, so
tune it so you get timely warnings without being spammed.

## Verify it worked

After enabling, open **Configuration → System → Disk Space Alert**
(`/admin/config/system/disk-space-alert`), set a threshold, and then use the
**manual check** (`/admin/config/system/disk-space-alert/manual-check`) to run an
immediate check. View current usage at `/admin/disk-space`.
