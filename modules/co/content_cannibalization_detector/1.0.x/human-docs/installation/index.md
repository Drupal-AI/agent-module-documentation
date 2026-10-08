# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **PHP 8.1 or higher**.
- Core's **Node** (`node`) and **Path Alias** (`path_alias`) modules — enabled
  automatically as dependencies.

**Recommended (optional):**

- **[Metatag](https://www.drupal.org/project/metatag)** — enables keyword extraction
  from meta description and keyword fields, improving accuracy.
- **Drush 12+** — enables the CLI analysis and reporting commands.

This project is **not covered** by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/content_cannibalization_detector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_cannibalization_detector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_cannibalization_detector -y
```

## Verify it worked

Grant the permissions (see [Configuration](../configuration/index.md)), then visit
**Reports → Content Cannibalization** (`/admin/reports/cannibalization`) and click
**Run Analysis**. After it scans your configured content, the severity table should
populate with any overlapping pages it finds. You can also confirm the CLI works
with `drush ccd:report`.
