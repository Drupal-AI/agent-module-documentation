# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- To read the entries you will want core's **Database Logging** (`dblog`) module
  enabled, so log messages are viewable at **Reports → Recent log messages**.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/permission_watchdog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/permission_watchdog -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permission_watchdog -y
```

Logging starts immediately — there is nothing to configure.

## Verify it worked

Make a small, deliberate change to a role's permissions at **People →
Permissions** (`/admin/people/permissions`) and save. Then open **Reports →
Recent log messages** (`/admin/reports/dblog`). You should see a new entry
recording that role's permission change. Keep access to the reports page
restricted, since these entries expose your site's permission structure and
history.
