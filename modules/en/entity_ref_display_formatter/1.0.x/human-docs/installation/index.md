# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core alone is required to install and enable it. The **Field UI** core module
  (enabled by default on most sites) is what you use to select the formatter on
  *Manage display*.
- Two display styles need an extra module: the **Vertical Tab** style needs
  *jQuery UI Tabs* (`drupal/jquery_ui_tabs`) and the **Accordion** style needs
  *jQuery UI Accordion* (`drupal/jquery_ui_accordion`). The Horizontal Tab and
  Anchors styles need nothing beyond core.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_ref_display_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_ref_display_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_ref_display_formatter -y
```

## Verify it worked

Go to the **Manage display** page of a bundle that has an entity reference field
(for example **Structure → Content types → Article → Manage display**). Open the
**Format** dropdown for that field — **"Entity reference Display formatter"**
should now be available to select. Pick it, then in its settings choose the
title field(s), content field(s), and a display style (tabs, accordion, or
anchors) and save; the referenced items render in that layout.
