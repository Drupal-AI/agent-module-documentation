# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Taxonomy Entity Index** module (`taxonomy_entity_index`) — a hard dependency.
  It maintains the index of which entities carry which taxonomy terms, which is what
  Backfill formatter queries to find similar content.
- At least one **entity‑reference field** whose target entities are categorised with
  taxonomy terms — otherwise there is nothing to match on.

## Install with Composer

From the project root:

```bash
composer require drupal/backfill_formatter -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Taxonomy Entity Index (if not already
present) and updates shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/backfill_formatter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en backfill_formatter -y
```

This enables Taxonomy Entity Index too if it wasn't already on. There is no settings
page — you apply the formatter on a field's **Manage display** tab, as described in the
*How to use it* section on the [overview page](../index.md).
