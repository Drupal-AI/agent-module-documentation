# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **jQuery UI** (`drupal/jquery_ui` `^1.7`) and **jQuery UI Draggable**
  (`drupal/jquery_ui_draggable` `^2.1`). Composer pulls both in for you — a drop
  target needs draggable items to interact with.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_droppable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the required `jquery_ui` and
`jquery_ui_draggable` packages.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_droppable -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_droppable -y
```

That is all — the `jquery_ui_droppable/droppable` library is now available to
attach. There is no configuration, and there are no submodules.
