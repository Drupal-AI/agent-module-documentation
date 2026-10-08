# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

No additional modules or libraries are required — the module works with Drupal core
APIs and Views configuration. Optional, recommended companions:

- **Views** — although optional, field usage in Views can only be detected when
  Views is enabled.
- **Devel** — handy for inspecting field info and entity structure alongside the
  report.

## Install with Composer

From the project root:

```bash
composer require drupal/field_usage_tracker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_usage_tracker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_usage_tracker -y
```

## Verify it worked

Grant the module's permission under **People → Permissions**, then navigate to
**`/admin/reports/field-usage`**. You should see the report listing all fields,
their target entity and bundle, and their usage status. No further configuration is
required.
