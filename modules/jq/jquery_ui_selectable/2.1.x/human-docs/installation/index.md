# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **[jQuery UI](https://www.drupal.org/project/jquery_ui)** module
  (`drupal/jquery_ui ^1.7`, at least version `8.x-1.7`) — this is what actually
  declares the Selectable asset library. Composer pulls it in for you.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_selectable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the jQuery UI module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_selectable -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_selectable -y
```

There are no submodules and nothing to configure. Once enabled, the
`jquery_ui_selectable/selectable` library is available to attach — see the
[overview](../index.md#how-to-use-it).
