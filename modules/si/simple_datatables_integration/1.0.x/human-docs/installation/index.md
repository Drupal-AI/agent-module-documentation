# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Views** module (part of standard Drupal) — this module adds a Views
  display format, so Views must be enabled.
- No other contrib dependencies and no extra PHP libraries.

Note: this project is **not covered by Drupal's security advisory policy**. Take
that into account when deciding whether to run it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_datatables_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_datatables_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_datatables_integration -y
```

There is no settings form to fill in — the module simply makes a new **Simple
DataTable** format available inside Views.

## Verify it worked

Edit or create a view, open its **Format** setting, and confirm that **Simple
DataTable** now appears as an option. Choosing it and saving turns the view's table
into an interactive, sortable, searchable one.
