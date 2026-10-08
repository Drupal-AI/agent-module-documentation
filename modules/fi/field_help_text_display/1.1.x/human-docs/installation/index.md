# Installation

## Requirements

- **Drupal 11 or higher** (`core_version_requirement: ^11`).
- Core's **Field UI** module (`field_ui`) enabled — this is the admin interface
  the Help text column is added to. It ships with Drupal core.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_help_text_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_help_text_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_help_text_display -y
```

If Field UI isn't already enabled, turn it on too:

```bash
drush en field_ui -y
```

There is no configuration to do — the column appears immediately.

## Verify it worked

Navigate to any entity type's **Manage fields** page, for example **Structure →
Content types → Article → Manage fields**. You should see a new **Help text**
column showing each field's configured description, with blank cells for fields
that have none.
