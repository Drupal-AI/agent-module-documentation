# Installation

## Requirements

Autocomplete Deluxe is lightweight and has no third-party dependencies:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other contrib modules are required — it builds on core's entity-reference
  and autocomplete systems, and it bundles its own jQuery UI assets, so there is
  nothing extra to download.

There are no PHP library or Composer requirements beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/autocomplete_deluxe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autocomplete_deluxe -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autocomplete_deluxe -y
```

That's all it takes. The module ships no submodules and no settings form. Once
enabled, "Autocomplete Deluxe" appears as a widget option on the *Manage form
display* tab for any entity-reference field — see
[the index page](../index.md#how-to-use-it) for how to apply and tune it.
