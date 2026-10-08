# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Search API** module (`search_api`).
- The **Views Filter Select** module (`views_filter_select`) —
  <https://www.drupal.org/project/views_filter_select>. This is a hard
  dependency; Composer pulls it in automatically with the command below.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_tracking -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Views Filter
Select and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_tracking -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_tracking -y
```

Drupal enables Search API and Views Filter Select as dependencies at the same
time.

## Verify it worked

Run a search through one of your Search API search forms, then open the bundled
**Search API Tracking** view under **Structure → Views**. Your search should
appear in the logged results. Review the module's permission on **People →
Permissions** so that only trusted roles can read the query log.
