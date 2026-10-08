# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||~9.0||^10||^11`).
- Core's **Filter** module (`filter`) — part of Drupal core.
- The contributed **Dynamic Entity Reference** module
  (`dynamic_entity_reference`) — version 1 is sufficient. Composer pulls this in
  automatically when you require the module below.

## Install with Composer

From the project root:

```bash
composer require drupal/filter_format_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Dynamic Entity
Reference and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filter_format_audit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filter_format_audit -y
```

Drupal enables Dynamic Entity Reference at the same time if it isn't already on.

## Grant the audit permission

Filter Format Audit provides its own permission so that only trusted staff can run
the analysis and read its results. Go to **People → Permissions**
(`/admin/people/permissions`), find the module's permission, and assign it to the
appropriate roles.

## Verify it worked

Log in as a user with the audit permission and visit **Content → Filter format
audit** (`/admin/content/filter-format-audit`). You should see the analysis page
with a **Run analysis** button. Running it should list where your text formats are
used. See the [main guide](../index.md#how-to-use-it) for the full workflow.
