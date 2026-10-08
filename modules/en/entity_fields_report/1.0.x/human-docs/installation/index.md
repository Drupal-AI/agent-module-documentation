# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`) and the **Paragraphs** module (`paragraphs`) —
  both are dependencies. Composer and Drush pull Paragraphs in with the `-W` flag
  below.
- No third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_fields_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Paragraphs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_fields_report -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_fields_report -y
```

This also enables `paragraphs` (and its dependencies) if they aren't already on.

## Grant the permission

The report is gated by the module's own permission. Under **People → Permissions**,
give the roles that should see the report that permission.

## Verify it worked

Go to **Reports → Entity Fields Report**
(`/admin/reports/entity-fields-report`). You should see the field report with its
filter controls and a CSV export button. See the parent [guide](../index.md) for
how to filter and export.
