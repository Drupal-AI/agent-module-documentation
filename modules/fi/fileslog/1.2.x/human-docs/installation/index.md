# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- A **working private filesystem** — the module writes logs under `private://logs`,
  so `file_private_path` must be set (see below). Get this right *before* enabling.
- No third‑party Composer or PHP library requirements.

> **Compatibility note:** version 1.0.3 was the last release compatible with Drupal
> 9. Use this 1.2.x branch on Drupal 10.1+ / 11.

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

You may want to disable core's **dblog** if you are switching over to file‑based
logging, so you aren't writing logs to both places.

## Who can see the logs

The log viewer is gated by the core **Access site reports** permission — the same
one that governs dblog. Grant it only to trusted administrators at **People →
Permissions**.

## Verify it worked

Visit **Reports → Recent log messages** (`/admin/reports/fileslog`). Trigger some
site activity (or run cron) and confirm entries appear, and that
`private://logs/…` contains timestamped JSON files. Click an entry to open its
detail page.
