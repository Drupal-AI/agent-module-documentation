# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Syslog** module (`syslog`) enabled, configured to write Drupal's log to a
  **specific file** — and that file must be readable by the web server user. This is
  the key prerequisite: Syslog Watcher can only show what it can read.
- No PHP extensions or external Composer libraries are listed as required.

## Install with Composer

From the project root:

```bash
composer require drupal/syslog_watcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/syslog_watcher -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en syslog_watcher -y
```

If core Syslog is not already on, enable it too (`drush en syslog -y`) and make sure
it logs to a dedicated file the web server can read.

## Verify it worked

As a user with the **Access site reports** permission, visit
**Reports → Syslog Watcher** (`/admin/reports/syslog-watcher`). Once you have pointed
the viewer at the correct file (see [Configuration](../configuration/index.md)), you
should see a paginated table of log entries, each linking to a detail page with the
raw line.
