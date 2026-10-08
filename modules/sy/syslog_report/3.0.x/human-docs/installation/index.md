# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Syslog** module (`syslog`) enabled, and the site actually logging to a
  syslog file the web server can read.
- The **jQuery UI Accordion** module, used for the report's interface.
- No PHP extensions or external Composer libraries are listed as required.
- Note that this module is **not covered by the security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/syslog_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/syslog_report -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en syslog_report -y
```

If core Syslog is not already on, enable it too (`drush en syslog -y`) and configure
Drupal to log to syslog.

## Grant the viewing permission

Syslog Report provides its own permission for viewing the report. At
**People → Permissions** (`/admin/people/permissions`), grant it **only** to trusted
administrator roles — the report can surface sensitive information (paths, IP
addresses, user actions) that lives in the log file.

## Verify it worked

Log in as a user with the report permission and open the Syslog Report screen from
the admin interface. You should see the records from your syslog file, with a
(case-sensitive) filter to narrow them down.
