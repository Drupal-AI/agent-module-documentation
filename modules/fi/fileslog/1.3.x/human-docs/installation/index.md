# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or later**.
- Core's **User** module (a declared dependency, enabled by default).
- A **working private filesystem** — the module writes logs under `private://logs`,
  so `file_private_path` must be set (see below). The module refuses to install
  without it.
- Core's **dblog must be disabled** — the two are incompatible and the module
  refuses to install alongside it.

There are no third‑party Composer or PHP library requirements.

## Configure a private filesystem first

Private Files Logging stores entries in the private file directory. If your site
doesn't already have one:

1. Choose a directory **outside the web root** (so it can't be fetched directly).
2. In `settings.php`, set:

   ```php
   $settings['file_private_path'] = '/path/outside/webroot/private';
   ```

3. Clear caches.

> **Why this matters:** if the private path is misconfigured *inside* the web root,
> the JSON log files become directly downloadable and the **Access site reports**
> permission is bypassed. Keep the directory outside the docroot.

## Disable dblog

If core's Database Logging is on, turn it off before enabling this module — the two
cannot run together:

```bash
drush pmu dblog -y
```

## Install with Composer

From the project root:

```bash
composer require drupal/fileslog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fileslog -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fileslog -y
```

If the private path or dblog prerequisites aren't met, installation stops with a
requirement error explaining what to fix.

## Who can see the logs

The log viewer is gated by the core **Access site reports** permission — the same
one that governs dblog. Grant it only to trusted administrators at **People →
Permissions**.

## Verify it worked

Visit **Reports → Recent log messages** (`/admin/reports/fileslog`). Trigger some
site activity (or run cron) and confirm entries appear, and that
`private://logs/…` contains one timestamped JSON file per event. You can also run
`drush fileslog:show` to see the latest entries from the command line.

## Next step

Set the retention limit so cron trims old log files — see
[Configuration](../configuration/index.md).
