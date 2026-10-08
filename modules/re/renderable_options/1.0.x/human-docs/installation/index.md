# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **Better Exposed Filters** module (`better_exposed_filters`) — this is a
  required dependency and must be present and enabled. Composer pulls it in
  automatically when you require Renderable Options with the `-W` flag.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/renderable_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Better Exposed
Filters and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/renderable_options -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en renderable_options -y
```

Drush enables Better Exposed Filters at the same time if it isn't already on,
since it is a dependency.

## Verify it worked

Edit a View that has an exposed filter, switch that filter to a Better Exposed
Filters checkbox/radio widget, and confirm you can now supply rendered markup for
the option labels. See [How to use it](../index.md#how-to-use-it) for the full
walkthrough.
