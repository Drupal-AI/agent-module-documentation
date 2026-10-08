# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Facets** module, version **2.x or 3.x** (`drupal/facets: ^2.0 || ^3.0`). This is a
  hard dependency and Composer pulls it in.
- In practice, the **Search API** module for the query side — Facets (and therefore Facets
  Form) filters a Search API index. Set up a working Search API + Facets faceted search first;
  Facets Form then changes how those facets are presented.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_form -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Facets and updates shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/facets_form -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_form -y
```

This enables Facets too if it wasn't already. Next, switch your facets over to the Facets Form
widgets and place the block — see [Configuration](../configuration/index.md).

## Submodules — enable only what you need

Each adds an extra in-form facet widget (or feature). Enable a submodule if you want its
capability:

| Submodule | Machine name | Adds |
|---|---|---|
| **Facets Form Date Range** | `facets_form_date_range` | A date-range filter form element. |
| **Facets Form Date Range Extended** | `facets_form_date_range_extended` | A date-range widget with quick pickers (this week, last month, …). |
| **Facets Form Fulltext** | `facets_form_fulltext` | A free-text search box as a facet. |
| **Facets Form Live Total** | `facets_form_live_total` | A live results-count feature. **Deprecated.** |

For example:

```bash
drush en facets_form_date_range -y
```

Each submodule requires the base Facets Form module, which is already present once you have
installed it above.
