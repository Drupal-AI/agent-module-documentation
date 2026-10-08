# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- The **Facets** module (`facets`) — a required dependency. Composer pulls it in
  automatically, and Drupal enables it as a dependency when you turn this module
  on. (Facets itself is used together with Search API.)

## Install with Composer

From the project root:

```bash
composer require drupal/static_facet_values -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required Facets module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/static_facet_values -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en static_facet_values -y
```

Drupal enables the required Facets module automatically as a dependency.

## Verify it worked

After enabling, edit any Facets facet and look at its **processor** settings — the
**Static facet values** processor should be available to switch on. It only does
something once you have written and registered a values service and selected it
here; see the [main guide](../index.md) and the
[`agent/`](../agent/start.md) docs for writing that service.
