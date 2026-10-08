# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10.0 || ^11`).
- Core's **Views** module (enabled by default on most sites) — the field is only useful inside a
  view.
- Core's **Path** module if you intend to use any of the *alias* output styles, so that URL
  aliases resolve.

There are no third‑party Composer or PHP library requirements, and no module dependencies beyond
core.

## Install with Composer

From the project root:

```bash
composer require drupal/views_current_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/views_current_path -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_current_path -y
```

That is all. There is no configuration screen — the **Global: Current path** field is now
available to add to any view (see [How to use it](../index.md#how-to-use-it)).

There are no submodules.
