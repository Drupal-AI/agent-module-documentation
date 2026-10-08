# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Field** (`field`) and **Field UI** (`field_ui`) modules — both enabled
  by default on most sites.

Optional: the **`ctools_entity_mask`** submodule (from
[Chaos Tools](https://www.drupal.org/project/ctools)). When present, Field Usage
Display also lists cross‑entity‑type borrowed fields.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_usage_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_usage_display -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_usage_display -y
```

## Verify it worked

Go to a **Manage fields** screen (**Structure → Content types → *(type)* → Manage
fields**). You should see a new **"Also used in"** column — populated for fields
that are shared across bundles, and blank for fields used only in the current
bundle. No configuration is needed.
