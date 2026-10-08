# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required — the module depends only on Drupal core.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_page_title_manage_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_page_title_manage_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_page_title_manage_display -y
```

## Verify it worked

Go to any entity type's **Manage display** page — for example **Structure →
Content types → Article → Manage display**. Expand the **Custom display
settings** section at the bottom and confirm that a **Page Title** display mode
is now available to enable. Once you customise it and view a full entity page,
your configured display replaces the default page‑title block. See the
"How to use it" section of the [overview](../index.md) for the full workflow.
