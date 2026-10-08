# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The base **jQuery UI** module (`jquery_ui` `^1.7`), which ships the vendored
  jQuery UI assets and registers this library on the module's behalf.
- **jQuery UI Controlgroup** (`jquery_ui_controlgroup` `^2.1`) and **jQuery UI
  Checkboxradio** (`jquery_ui_checkboxradio` `^2.1`) — the Button widget's library
  declares these as dependencies, so they are required. Composer and Drupal pull
  all three in automatically.

There are no other third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the base
`jquery_ui`, `jquery_ui_controlgroup`, and `jquery_ui_checkboxradio` modules and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_ui_button -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_button -y
```

This enables the base `jquery_ui`, `jquery_ui_controlgroup`, and
`jquery_ui_checkboxradio` modules alongside it. There are no submodules and no
configuration — once enabled, the `jquery_ui_button/button` library is available
to attach (see the [overview](../index.md)).

## A note before you rely on it

jQuery UI is End‑of‑Life upstream. Enable this module as a compatibility bridge
for existing code that still needs the Button widget; for new work, prefer a
maintained alternative.
