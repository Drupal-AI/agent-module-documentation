# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
  Drupal 10 is recommended; Drupal 8 is probably supported but no longer tested.
- No other modules are required — it depends only on Drupal core. The **Field UI**
  core module is what you use to select the formatter on *Manage display*.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_ajax_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_ajax_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_ajax_formatter -y
```

## Verify it worked

Go to the **Manage display** page of a bundle with a multi‑value entity reference
field (for example **Structure → Content types → Article → Manage display**).
Open the **Format** dropdown for that field — the AJAX formatter should now be
selectable. Enable **Load more**, save, and view an entity with several
references: you should see the initial batch plus a **Load more** link that pulls
in more references inline.
