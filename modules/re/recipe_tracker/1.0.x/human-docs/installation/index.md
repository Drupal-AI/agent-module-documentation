# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`) — the module relies on core's
  Recipe system, which is Drupal 11.
- No contrib dependencies, and no third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/recipe_tracker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recipe_tracker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recipe_tracker -y
```

There are no submodules. From the moment it's enabled, Recipe Tracker starts
logging each recipe that is applied. Note it can only record recipes applied
*after* installation — anything applied earlier won't appear.

## Grant the permission

Assign **Administer logs** (`administer recipe_tracker_log`) to the roles that
should be able to view and manage the recipe log. It's a restricted‑access
permission, so grant it only to trusted administrators.

## Verify it worked

Apply a recipe (or wait for your next deployment that does), then visit
**Extend → Recipe log** (`/admin/modules/recipe-log`). You should see a new entry
naming the recipe, its package and version, who applied it, and the timestamp.
