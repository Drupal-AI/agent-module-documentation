# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** and **Views** modules (both are in Drupal core; enable them if
  they are not already on). The module extends core Taxonomy to add its Views
  filter.
- A **media** entity type with a field that references a taxonomy vocabulary — you
  will point the filter at that field's machine name.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_taxonomy_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_taxonomy_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_taxonomy_filter -y
```

## Verify it worked

Edit a **media** View at **Structure → Views**, and under **Advanced → Contextual
filters** (or the regular filter list) click **Add**. Confirm **Media has taxonomy
term ID (with depth)** now appears in the list. The rest of the setup is in
[How to use it](../index.md#how-to-use-it).
