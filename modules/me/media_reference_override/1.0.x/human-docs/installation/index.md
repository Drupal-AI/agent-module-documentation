# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** (`media`), **Media Library** (`media_library`), **Image**
  (`image`), and **File** (`file`) modules enabled — Drupal will pull these in as
  dependencies.
- At least one **media reference field** on a content type, paragraph, block, or
  other fieldable entity.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_reference_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_reference_override -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_reference_override -y
```

The module provides its own permission; review it on **People → Permissions** and
grant it to the roles that should be able to enter overrides.

## Verify it worked

Enable the override widget on a media reference field's **Manage form display** and
the matching formatter on **Manage display** (see the [overview](../index.md)).
Then edit a piece of content, select a media item, and confirm the inline override
section appears beneath it. Enter a custom alt text, save, and check that the
rendered page uses the overridden value while the original media entity remains
unchanged.
