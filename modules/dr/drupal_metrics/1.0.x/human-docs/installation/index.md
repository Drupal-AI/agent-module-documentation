# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies, no third‑party Composer packages, and no external
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drupal_metrics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupal_metrics -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupal_metrics -y
```

## Grant the report permission

Drupal Metrics provides its own permission that gates the report. Because the
metrics expose operational details about the site's database, grant it only to
trusted administrator roles:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the Drupal Metrics permission and tick it for the roles that should be
   able to view the report.
3. Click **Save permissions**.

## Verify it worked

Log in as a user with the permission you just granted and go to **Reports**
(`/admin/reports`). You should see the Drupal Metrics report listed. Open it to
confirm table sizes and content‑type counts are displayed.
