# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (enabled on most sites) — the plugin is only useful inside a view.

There are no third‑party Composer or PHP library requirements, and no module dependencies beyond
core.

## Install with Composer

From the project root:

```bash
composer require drupal/views_arg_entity_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/views_arg_entity_field -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_arg_entity_field -y
```

That is all. There is no configuration screen — the **Field value from Current Entity** default
becomes available on any contextual filter (see
[How to use it](../index.md#how-to-use-it)).

> **Upgrading from an older version?** The module ships a database update (`hook_update_8201`)
> that converts a legacy string `single_value_delta` setting to an integer. Run
> `drush updatedb -y` after updating so existing views migrate cleanly.

There are no submodules.
