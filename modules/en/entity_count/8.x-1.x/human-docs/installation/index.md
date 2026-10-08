# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No third‑party Composer packages, PHP libraries, or contrib module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_count -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_count -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_count -y
```

## Grant the report permission

The report is protected by the **"Access entity count"** permission. Under **People
→ Permissions**, grant it to the roles that should be able to see the counts.
Because the totals include entities a viewer might not otherwise be able to access,
limit this to trusted administrators.

## Verify it worked

Log in as a user with the permission and visit **Administration → Reports →
Entity count** (`/admin/reports`). You should see a table of entity types with
their counts, and a per‑bundle breakdown for any type that has more than one bundle.
