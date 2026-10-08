# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Content Translation** module (`content_translation`) enabled — this is a
  required dependency, and Drupal enables it automatically when you turn on Entity
  Translation Sync.

There are no third‑party Composer or PHP library requirements.

> **Note:** Paragraph fields, and any field type based on entity reference
> revisions, are **not supported** by the sync.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_translation_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_translation_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_translation_sync -y
```

## Verify it worked

After enabling, go to **Configuration → Regional and language → Entity translation
sync** (`/admin/config/regional/entity-translation-sync`) and confirm the settings
form loads. Follow [Configuration](../configuration/index.md) to enable the
entities and fields, clear caches, and assign permissions — then confirm the
**"Entity translation sync"** tab appears on a supported translatable entity.
