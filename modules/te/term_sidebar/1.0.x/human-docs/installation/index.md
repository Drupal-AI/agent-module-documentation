# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Uses core's Taxonomy module (which you'll already have if you're editing
  terms). No other module dependencies and no third‑party libraries.

For the fully styled two‑column result, use the **Claro** or **Gin** admin theme
(or a subtheme of either). Other themes still get the regions, but without the
theme‑specific styling and action‑bar handling.

## Install with Composer

From the project root:

```bash
composer require drupal/term_sidebar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/term_sidebar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_sidebar -y
```

That's all. There is no configuration. Open any taxonomy term's add or edit form
and you'll see the new two‑column layout with an advanced sidebar.
