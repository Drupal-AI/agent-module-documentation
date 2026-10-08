# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third-party Composer or PHP library requirements. Note this project
has **no security advisory coverage** and is minimally maintained, so review it
before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/permissions_analyzer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/permissions_analyzer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permissions_analyzer -y
```

## Verify it worked

Log in as a user with the **Administer permissions** permission and go to
**Reports → Permissions Analyzer** (`/admin/reports/permissions-analyzer`). You
should see the dashboard with a global security score and a per-role breakdown.
Because it only reads your configuration, it makes no changes — it is safe to run
on a live site to see where you stand. Keep the report restricted to
`administer permissions` holders, since it highlights your site's weak spots.
