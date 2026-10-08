# Installation

## Requirements

Body node ID Class is a single‑hook theming helper with no moving parts. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** module (part of a standard Drupal install) — the classes are added
  on node pages.

There are no third‑party Composer packages, no PHP library requirements, and no
other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/body_node_id_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/body_node_id_class -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en body_node_id_class -y
```

## Clear caches

Because the behavior is a preprocess hook, clear caches once after enabling so it
takes effect:

```bash
drush cr
```

## Verify it worked

Open any node page and view its HTML source. The `<body>` tag should now include
classes such as `page-node-42` and `page-node-type-article`. There is no
configuration — see the [overview](../index.md#how-to-use-it) for how to target the
classes from CSS.
