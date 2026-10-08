# Installation

## Requirements

jQuery UI Draggable is a thin library wrapper. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **jQuery UI** module (`drupal/jquery_ui`, `^1.7`) — this is the only
  dependency. It supplies the underlying jQuery UI core files and fills in this
  module's empty library stub at build time. Composer installs it automatically.

There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_draggable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `jquery_ui`
base module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_draggable -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable both this module and its `jquery_ui` dependency (Drush will pull the
dependency in automatically):

```bash
drush en jquery_ui_draggable -y
```

That's all. The `jquery_ui_draggable/draggable` library is now available for any
theme or module to attach — see the **How to use it** section on the
[overview page](../index.md) for how to depend on and attach it.

There is no configuration page and nothing else to set up.
