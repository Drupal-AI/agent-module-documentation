# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **jQuery UI** module (`drupal/jquery_ui`, `^1.7`) — the base module that
  actually declares the `selectmenu` library on this module's behalf.
- The **jQuery UI Menu** module (`drupal/jquery_ui_menu`, `^2.1`) — the Selectmenu
  widget builds its menu using the jQuery UI Menu widget, so this must be present.

Composer installs both dependencies for you. The module has no third‑party PHP
libraries, no permissions, and no configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_selectmenu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `jquery_ui`
and `jquery_ui_menu` dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_ui_selectmenu -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_selectmenu -y
```

Drupal enables the `jquery_ui` and `jquery_ui_menu` dependencies at the same
time. There are no submodules and no settings page.

## Next step

There is nothing to configure. Attach the `jquery_ui_selectmenu/selectmenu`
library and initialize the widget in your own JavaScript — see the
[overview](../index.md) for the attach and init snippets.
