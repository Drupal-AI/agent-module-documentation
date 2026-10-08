# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **jQuery UI** module (`drupal/jquery_ui`, `^1.7`) — this is the module that
  actually vendors the jQuery UI files and fills in the Sortable library. Composer
  installs it for you, and Drupal enables it as a dependency.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_sortable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `jquery_ui`
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_sortable -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_sortable -y
```

The base `jquery_ui` module is enabled automatically as a dependency. That is all
that is required — the `jquery_ui_sortable/sortable` library now resolves and can be
attached. There is no configuration and no submodules.

## Verify it worked

Attach the library somewhere (or confirm an existing legacy reference now resolves)
and load the page — the resolved library loads jQuery UI's `sortable-min.js`. If a
theme or contrib module already depends on `jquery_ui_sortable/sortable`, its
drag-and-drop reordering should start working again. See the
[How to use it](../index.md#how-to-use-it) section for how to attach it.

> **Remember:** jQuery UI is end-of-life. Use this module only to keep legacy code
> running; prefer **SortableJS** (core's replacement) for anything new.
