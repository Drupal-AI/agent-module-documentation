# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Islandora** module (`islandora`).
- The **Controlled Access Terms** module (`controlled_access_terms`).
- An `islandora_object` content type carrying the descriptive metadata the citation
  is built from.

## Install with Composer

From the project root:

```bash
composer require drupal/islandora_csl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required modules
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/islandora_csl -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en islandora_csl -y
```

Drupal enables the Islandora and Controlled Access Terms dependencies at the same
time if they are not already on.

## Verify it worked

Go to your `islandora_object` content type's **Manage display**
(`/admin/structure/types/manage/islandora_object/display`). The
**`field_islandora_csl`** pseudo-field should be listed. Move it into a visible
region, save, then view an Islandora object — a formatted citation should appear.
