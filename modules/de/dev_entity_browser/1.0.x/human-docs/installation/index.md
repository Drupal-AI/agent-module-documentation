# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies, and no third-party Composer or PHP libraries.

This module is covered by Drupal's security advisory policy, but as a developer
inspection tool it should be restricted to trusted roles and is best kept off
production.

## Install with Composer

From the project root:

```bash
composer require drupal/dev_entity_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dev_entity_browser -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dev_entity_browser -y
```

## Grant the permission

After enabling, go to **People → Permissions** (`/admin/people/permissions`) and
grant **View Dev Entity Browser** to the roles that should be able to open the
report. Because the dashboard reveals site structure and configuration, grant it
only to trusted developers and administrators.

## Verify it worked

Log in as a user with the **View Dev Entity Browser** permission and open the
**Reports** menu (`/admin/reports`). The Developer Entity Browser dashboard should
be listed there.
