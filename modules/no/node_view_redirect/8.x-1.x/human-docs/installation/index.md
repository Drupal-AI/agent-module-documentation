# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A standard Drupal node system.

There are no third‑party Composer or PHP library requirements, and no additional
contributed‑module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/node_view_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_view_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_view_redirect -y
```

## Verify it worked

Go to **Structure → Content types**, edit a content type, and set a redirect target
path. Save, then view a node of that type — you should be redirected to the path you
configured. See the [overview](../index.md) for the step‑by‑step and cautions about
loops.
