# Installation

## Requirements

Data Count is intentionally minimal. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- **No modules outside Drupal core** — there are no other module, Composer, or
  PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/data_count -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/data_count -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en data_count -y
```

## Verify it worked

Log in as an administrator and go to **Reports → Data Count**
(`/admin/reports/data-count`). You should see the **Node Count Details** and
**User Count Details** tabs with per‑type and per‑role totals. If the numbers
look right for your site, the module is working — there is nothing else to set
up.
