# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Search API** (`search_api`) — provides the index and the processor framework.
- **Facets** (`facets`) — provides the facet the module exposes.
- **Type Tray** (`type_tray`) — supplies the content‑type groupings that become
  the facet.

All three are required modules and Composer will pull them in with the command
below. This project is **not covered by Drupal's security advisory policy**, so
review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/facet_type_tray -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Search API, Facets, and Type Tray.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facet_type_tray -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facet_type_tray -y
```

This also ensures Search API, Facets, and Type Tray are enabled.

## Verify it worked

Open your Search API index's **Processors** tab and confirm the **Type Tray**
processor is available to enable. After enabling it and re‑indexing, add a facet
for the Type Tray category field and check that the **Type Tray – Merge node
types** build processor and **Sort by Type Tray categories** sort processor appear
in the facet's processor list. See "How to use it" in the
[overview](../index.md) for the full sequence.
