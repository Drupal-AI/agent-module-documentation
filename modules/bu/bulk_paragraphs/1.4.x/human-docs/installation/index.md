# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- The contributed **Paragraphs** module (`paragraphs`) enabled.
- Core's **Datetime** module (`datetime`) enabled.

Composer pulls in Paragraphs for you, and Drupal enables Datetime automatically
as a dependency when you turn on Bulk Paragraphs.

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bulk_paragraphs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_paragraphs -y
```

## Grant the permission

After enabling, give the roles that should be able to bulk-create paragraphs the
**`use bulk paragraphs`** permission at **People → Permissions**
(`/admin/people/permissions`). Without it, the bulk option does not appear.
