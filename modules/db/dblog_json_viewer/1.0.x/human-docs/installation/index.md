# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Database Logging** module (`dblog`) — enabled automatically as a
  dependency.
- A modern browser with ES6+ support. The JavaScript viewer library (`jsonview.js`)
  is bundled with the module — there is nothing external to install.

The **Gin** admin theme is recommended for the best visual integration and dark-mode
support, but any admin theme works.

## Install with Composer

From the project root:

```bash
composer require drupal/dblog_json_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dblog_json_viewer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dblog_json_viewer -y
```

Enabling it also enables core's `dblog` module if it isn't already on. The viewer
starts working immediately — no configuration needed.

## Verify it worked

Open **Reports → Recent log messages** (`/admin/reports/dblog`) and click into a
log entry that contains JSON data. Instead of a plain-text dump you should see an
interactive, syntax-highlighted JSON viewer with a search box and expand/collapse
controls. If you'd like to tune it, see [Configuration](../configuration/index.md).
