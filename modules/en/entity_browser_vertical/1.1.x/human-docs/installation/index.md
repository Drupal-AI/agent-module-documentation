# Installation

## Requirements

Entity Browser Vertical needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Entity Browser** module (`entity_browser`) — a declared dependency. Composer
  pulls it in, and Drupal enables it automatically. You also need at least one Entity
  Browser configured and wired to an entity‑reference field for this module to have
  anything to style.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_browser_vertical -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and brings in Entity Browser.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_browser_vertical -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_browser_vertical -y
```

Drupal enables `entity_browser` at the same time as a dependency. There is no
settings page and no permissions — the module simply adds a new display option to
Entity Browser widgets.

## Submodules

This module ships no submodules — the base module is everything.

## Verify it worked

Edit a form display that has an entity‑reference field using the **Entity browser**
widget, open the widget settings, and confirm that **"Entity label, stacked
vertically"** now appears as an **Entity display plugin** option. See the
[overview](../index.md#how-to-use-it) for how to apply it.
