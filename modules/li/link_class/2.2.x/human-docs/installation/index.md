# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Link** module (`link`) enabled — this is the only dependency and Drupal enables it
  automatically as a dependency when you turn on Link Class.

There are no third‑party libraries or special PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/link_class -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_class -y
```

This enables core `link` as a dependency if it isn't already on. There are no submodules and
nothing to configure globally.

## After enabling

The **Link with class** widget is now available for any Link field. Switch a field to it on
**Manage form display** and pick a mode — see
[How to use it](../index.md#how-to-use-it). Swapping an existing Link field to this widget
needs no data migration.
