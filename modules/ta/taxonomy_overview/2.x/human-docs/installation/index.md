# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Taxonomy** (`taxonomy`) and **Node** (`node`) modules.
- The contributed **Paragraphs** module (`paragraphs:paragraphs`) — this is a
  dependency so that merges can update references stored on paragraphs. Composer
  installs it automatically with the command below.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_overview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_overview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_overview -y
```

## After installing and after updates

This module stores data in its own schema fields, so run the database and cache
updates whenever you install or update it:

```bash
drush updb -y
drush cr
```

- Run `drush updb` after module updates that add schema fields.
- Run `drush cr` after route, menu, or command changes.

## Verify it worked

Log in as an administrator and visit **Reports → Taxonomy Insights**
(`/admin/reports/taxonomy`). If the Insights dashboard loads with a health score and a
per-vocabulary summary, the module is installed and working. Next, grant the action
plan permissions to the right roles — see [Configuration](../configuration/index.md).
