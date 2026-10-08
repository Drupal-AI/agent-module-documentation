# Installation

## Requirements

Views Tree is lightweight and has no third-party libraries:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Views** module (`views`) enabled — this is the core module the style
  plugins plug into. It's part of Drupal core and is enabled on virtually every
  site.

There are no Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_tree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_tree -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_tree -y
```

That's all it takes. The **Tree (list)** and **Tree (table)** styles are now
available in any view's Format settings, along with the tree-based
entity-reference selection handler. See the
[overview](../index.md#how-to-use-it) for how to switch a view to a tree style and
set its Main and Parent fields.
