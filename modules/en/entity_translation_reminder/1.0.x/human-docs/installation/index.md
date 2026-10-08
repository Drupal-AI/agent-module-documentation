# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Content Translation** module (`content_translation`) enabled — this is a
  required dependency, and Drupal enables it automatically when you turn on Entity
  Translation Reminder.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_translation_reminder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_translation_reminder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_translation_reminder -y
```

## Verify it worked

After enabling, go to **Configuration → Regional and language → Entity Translation
Reminder** (`/admin/config/regional/entity-translation-reminder`) and confirm the
settings form loads. Choose the entity types and bundles that should show the
reminder (see [Configuration](../configuration/index.md)), then save a translated
entity of one of those bundles to confirm the reminder message appears.
