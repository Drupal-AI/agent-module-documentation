# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Four other jQuery UI contrib modules, which supply the assets and the widgets
  the dialog depends on. All are installed automatically by Composer:
  - **jQuery UI** (`drupal/jquery_ui`, `^1.7`) — carries the vendored jQuery UI
    1.13.2 assets.
  - **jQuery UI Button** (`drupal/jquery_ui_button`, `^2.1`) — the dialog's button
    pane.
  - **jQuery UI Draggable** (`drupal/jquery_ui_draggable`, `^2.1`) — the drag
    handle.
  - **jQuery UI Resizable** (`drupal/jquery_ui_resizable`, `^2.1`) — the resize
    grips.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_dialog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed — here it also brings in the four jQuery UI modules above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_dialog -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_dialog -y
```

Drush enables the four dependency modules at the same time. There is no
configuration, no permissions, and no settings form — enabling the module is the
entire installation. The `jquery_ui_dialog/dialog` library is now available for any
code to attach (see the [main guide](../index.md#how-to-use-it)).
