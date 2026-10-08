# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`). Version 10.2
  is the floor because that is where Drupal Core's `entity_reference` Views filter
  became available.
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on this module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_core_entity_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_core_entity_reference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_core_entity_reference -y
```

Then rebuild caches so Views reads the updated field data:

```bash
drush cr
```

That's all it takes. There is no configuration form. Edit any View with an
entity‑reference filter and it will now offer a Select/Autocomplete widget of the
referenced entities.

If you are migrating off the old core entity_reference Views filter *patch*, the
module runs a one‑time cleanup of your existing views during install — no manual
steps needed. It strips the `_reference` suffix the patch added to filter ids and
operators so your existing views keep working.
