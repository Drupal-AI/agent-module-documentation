# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Two contributed modules for the drag‑and‑drop builder:
  - **jQuery UI Draggable** (`jquery_ui_draggable`)
  - **jQuery UI Resizable** (`jquery_ui_resizable`)

  Composer pulls these in automatically when you require orgchart with the `-W`
  flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/orgchart -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the jQuery UI
Draggable and Resizable dependencies alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/orgchart -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en orgchart -y
```

Enabling orgchart also enables its jQuery UI dependencies.

## Verify it worked

Log in as an administrator and visit `/admin/config/orgchart`. You should see the
orgchart management screen with an option to add a chart. From there, follow
[Configuration](../configuration/index.md) to set your defaults and build your
first chart.
