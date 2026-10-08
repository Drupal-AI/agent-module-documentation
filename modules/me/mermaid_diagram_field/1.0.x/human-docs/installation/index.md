# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other Drupal modules are required. To store diagrams in a field you will use
  core's Field UI (**Field UI**), which is standard on most sites.
- The rendering libraries — **Mermaid** (11.11.0) and **svg‑pan‑zoom** (3.6.2) —
  load from the jsDelivr CDN by default, so no PHP or Composer library is needed.
  If your site must self‑host front‑end assets, you can override the library
  definitions in a custom module or theme and point them at local copies.

There are no third‑party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mermaid_diagram_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mermaid_diagram_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mermaid_diagram_field -y
```

Or enable **Mermaid Diagram field** from *Extend* (`/admin/modules`) in the admin UI.

There are no submodules and no required configuration. Once the module is enabled,
add a **Mermaid diagram** field to a content type (or any fieldable entity) and
configure its display — see [How to use it](../index.md#how-to-use-it).
