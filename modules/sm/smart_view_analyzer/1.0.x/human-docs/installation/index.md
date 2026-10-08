# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`) enabled — the only dependency, and it is what
  the analyzer inspects. Drupal enables it as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_view_analyzer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_view_analyzer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_view_analyzer -y
```

## Set up permissions

Smart View Query Analyzer provides its own permission. Because the tool inspects
View definitions and query performance, grant it only to trusted developers at
**Administration → People → Permissions**.

## Verify it worked

Log in as a user with the analyzer permission and open the module's dashboard. You
should see every View on the site listed with a risk level (Low, Medium, High, or
Critical) and an **Analyze →** link on each row for a detailed breakdown.
