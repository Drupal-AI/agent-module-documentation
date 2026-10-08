# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **Flag** module (`drupal/flag`) — required.
- **Search API** module (`drupal/search_api`) — required.
- **Facets** module (`drupal/facets`) — only needed if you want the "flagged by
  me" (`user_flag`) facet widget.

Both Flag and Search API are hard dependencies; Drupal will refuse to enable Flag
Search API until they are present.

## Install with Composer

From the project root:

```bash
composer require drupal/flag_search_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Flag, Search API,
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flag_search_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flag_search_api -y
```

This will also enable Flag and Search API if they are not already on. If you plan
to use the facet checkbox, enable Facets too:

```bash
drush en facets -y
```

There are no submodules. Once enabled, head to your Search API index's
**Processors** tab to turn on Flag indexing — see the
[main guide](../index.md#how-to-use-it) for the step‑by‑step.
