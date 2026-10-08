# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Schema.org Metatag** module (`schema_metatag`) — the framework this module
  plugs into, which in turn builds on the contributed **Metatag** module.
- The **Schema.org Accommodation** module (`schema_accommodation`), which
  VacationRental extends.

Both dependencies must be present and enabled. There are no PHP‑library or other
third‑party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_vacation_rental -W
```

The Composer package name (`drupal/schema_vacation_rental`) matches the module's
machine name (`schema_vacation_rental`). The `-W` (`--with-all-dependencies`) flag
lets Composer pull in Schema.org Metatag, Schema.org Accommodation, and any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_vacation_rental -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_vacation_rental -y
```

Enabling it will also enable `schema_metatag`, `schema_accommodation`, and Metatag
if they are not already on.

## Verify it worked

Go to **Configuration → Search and metadata → Metatag**
(`/admin/config/search/metatag`), edit a content type's meta tags, and confirm you
see a **Schema.org: VacationRental** section among the available fields.
