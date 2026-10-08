# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The contrib **CTools** module (`drupal/ctools` `^3.15 || ^4.1`).
- The contrib **jQuery UI Droppable** module (`drupal/jquery_ui_droppable`
  `^1.0 || ^2.0`) — used by the in-place editor's drag-and-drop.
- Core's **Layout Discovery** module (`layout_discovery`), which provides the
  layouts Panels arranges content into.

Composer pulls the CTools and jQuery UI Droppable dependencies in for you.

**Important:** Panels provides no page-building UI on its own. To actually build
pages you also need **Page Manager** (part of the CTools project) enabled, and/or
the bundled **Panels IPE** submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/panels -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in CTools and jQuery UI Droppable.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/panels -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Panels together with Page Manager so you have somewhere to build displays:

```bash
drush en panels page_manager -y
```

## Submodule — Panels IPE

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Panels IPE** | `panels_ipe` | The JavaScript **In-Place Editor** — edit layouts and blocks directly on the rendered front end, dragging panes between regions and adding new block content inline. |

Enable it if you want on-page editing:

```bash
drush en panels_ipe -y
```
