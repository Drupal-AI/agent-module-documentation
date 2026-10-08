# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Drush** to run the audit from the command line (the richest way to use the
  module). The admin report page works without Drush.

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/site_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_audit -W`,
> `ddev drush audit-all`. Inside the container (`ddev ssh`) run them without the
> prefix.

## Enable the module

```bash
drush en site_audit -y
```

You can now run `drush audit-all` or visit `/admin/reports/site-audit`. See
[Configuration](../configuration/index.md) for how to run and tune the reports.

## Optional submodules

Site Audit ships two optional submodules — enable them only if you need them:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Site Audit Report Entity** | `site_audit_report_entity` | Saves audit results as a content entity so you can keep and revisit historical reports over time. |
| **Site Audit Send** | `site_audit_send` | Sends audit reports to a remote Site Audit server, and can do so automatically on a cron schedule. |

Enable either with `drush en`, for example:

```bash
drush en site_audit_report_entity -y
```
