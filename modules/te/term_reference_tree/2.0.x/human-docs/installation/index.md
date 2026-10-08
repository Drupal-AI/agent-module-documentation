# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled — the widget and formatter build
  a tree from taxonomy vocabularies, so Taxonomy is required. Drupal enables it as
  a dependency automatically.

There are no third-party PHP library or Composer requirements; the tree's
expand/collapse behavior uses Drupal's bundled jQuery.

## Install with Composer

From the project root:

```bash
composer require drupal/term_reference_tree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_reference_tree -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_reference_tree -y
```

The module ships no submodules and no settings form. Once enabled, **Term
reference tree** appears as a widget option on the *Manage form display* tab, and
**Term Reference Tree** as a formatter on the *Manage display* tab, for any
entity-reference field that targets taxonomy terms — see
[the index page](../index.md#how-to-use-it) for how to apply and tune it.
