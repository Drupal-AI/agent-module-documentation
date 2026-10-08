# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Link** (`link`) and **Node** (`node`) modules — both ship with Drupal
  and are enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/external_link_status_check -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_link_status_check -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_link_status_check -y
```

## Verify it worked

Log in as an administrator and visit **Reports → External Links**
(`/admin/reports/external-links`). The report page should load, ready to fill up
as content is scanned. To prime it, create or update a node that contains an
external link, then run cron (`drush cron`) so the queued status checks are
processed. From there, head to [Configuration](../configuration/index.md) to tune
how scanning behaves.
