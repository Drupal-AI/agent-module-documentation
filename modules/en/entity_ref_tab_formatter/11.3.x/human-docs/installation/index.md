# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required — it depends only on Drupal core, and its
  JavaScript is built on core's `once()` with **no jQuery UI dependency**. The
  **Field UI** core module is what you use to select the formatter on *Manage
  display*.
- No third‑party Composer or PHP library requirements. (For the "Views block"
  body option you will need a Views block display to point at, but core Views
  provides that.)

## Install with Composer

From the project root:

```bash
composer require drupal/entity_ref_tab_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_ref_tab_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_ref_tab_formatter -y
```

Clear caches afterwards if needed (`drush cr`).

## Verify it worked

Go to the **Manage display** page of a bundle with a multi‑value entity reference
(or Paragraphs) field. Open the **Format** dropdown for that field — **Entity
reference tab formatter** should now be selectable. Choose it, configure the tab
title and body options, save, and view an entity: the references should render as
tabs (or an accordion, depending on your choice).
