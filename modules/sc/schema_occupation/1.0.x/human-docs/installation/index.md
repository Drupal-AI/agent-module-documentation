# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Schema.org Metatag** module (`schema_metatag`) — this is the framework
  that Schema.org/Occupation plugs into, and it must be present and enabled.
  Schema.org Metatag in turn builds on the contributed **Metatag** module.

There are no PHP‑library or other third‑party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_occupation -W
```

The Composer package name (`drupal/schema_occupation`) matches the module's
machine name (`schema_occupation`). The `-W` (`--with-all-dependencies`) flag lets
Composer pull in Schema.org Metatag and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_occupation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_occupation -y
```

Enabling it will also enable `schema_metatag` (and Metatag) if they are not
already on.

## Verify it worked

Go to **Configuration → Search and metadata → Metatag**
(`/admin/config/search/metatag`), edit a content type's meta tags, and confirm you
see a **Schema.org: Occupation** section among the available fields. That
confirms the type is registered and ready to map.
