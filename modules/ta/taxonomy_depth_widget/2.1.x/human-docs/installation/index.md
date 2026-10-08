# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Taxonomy** module (`taxonomy`) — enabled automatically as a dependency.
- A content type (or other fieldable entity) with a **taxonomy term‑reference
  field** pointing at a **hierarchical** vocabulary — this is what you apply the
  depth constraint to.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_depth_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_depth_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_depth_widget -y
```

## Verify it worked

Go to a content type's **Manage form display** and open the widget settings for
a taxonomy term‑reference field. If the depth options provided by this module
appear in the widget's settings, the module is installed correctly. See
[Configuration](../configuration/index.md) to set the depth.
