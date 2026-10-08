# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No module dependencies are declared.
- Your **theme must provide Bootstrap CSS/JS** — the formatter outputs Bootstrap
  accordion/tab markup and relies on Bootstrap (and, for responsive tabs, the
  Bootstrap Responsive Tabs library) to style and animate it.

There are no third‑party Composer requirements beyond Drupal itself.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_bs_accordion_tab_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_bs_accordion_tab_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_bs_accordion_tab_formatter -y
```

## Verify it worked

Go to **Structure → *(a content type or paragraph type)* → Manage display**. For an
entity-reference or Paragraphs field, the **Format** select list should now offer
the Bootstrap accordion/tab formatter. Choose it, pick accordion or tab, save, and
view an entity with values in that field to confirm the referenced targets render
as accordions or tabs.
