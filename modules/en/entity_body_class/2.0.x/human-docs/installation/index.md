# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_body_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_body_class -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_body_class -y
```

## Verify it worked

Enabling the module adds a **"Body CSS class(es)"** field to entities with canonical
routes. Edit a node (or another such entity), enter a class name in that field, save,
and view the page — the class should appear on the `<body>` element (check with your
browser's inspector). If you don't see the field on the form, grant your role the
"Manage body class fields" permission; see [Configuration](../configuration/index.md).
