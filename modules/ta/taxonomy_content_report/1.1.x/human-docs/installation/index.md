# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core **Taxonomy** (`taxonomy`), **Node** (`node`) and **Views** (`views`),
  plus Views UI for editing the embedded Views. Drupal enables these as
  dependencies.
- At least one **vocabulary** and one or more content types with an
  entity‑reference field pointing at that vocabulary — this is what the report
  filters on.

There are no extra PHP libraries to install (the summary chart uses Chart.js,
which the module provides).

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_content_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_content_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_content_report -y
```

## Set permissions

The module provides separate **view** and **administer** permissions at
**People → Permissions** (`/admin/people/permissions`). Because the report shows
content in aggregate — and can include unpublished nodes — grant the view
permission only to roles that should see that overview.

## Verify it worked

Go to **Configuration → Content → Taxonomy Content Report Settings**
(`/admin/config/content/taxonomy-content-report`). If the settings form loads
and lets you choose a vocabulary, the module is installed correctly. Continue
with [Configuration](../configuration/index.md).
