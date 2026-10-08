# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **modern browser with localStorage support** and **JavaScript enabled** — the
  history is stored and displayed entirely client-side.
- **No other modules or libraries** are required; the module works with Drupal
  core alone.

## Install with Composer

From the project root:

```bash
composer require drupal/search_tracker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_tracker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_tracker -y
```

## After enabling

The module does not surface anything until you configure it and place its block:

1. **Assign the permission** — on **People → Permissions**
   (`/admin/people/permissions`), grant **Administer Search Tracker settings** to
   the roles that should manage the module.
2. **Configure the settings** — see [Configuration](../configuration/index.md).
3. **Place the block** — add the **Search Tracker** block to a region under
   **Structure → Block layout** (`/admin/structure/block`).

## Verify it worked

After configuring the module and placing the block, run a search on one of your
configured paths. Your search term should appear in the Search Tracker block as a
clickable recent-search link.
