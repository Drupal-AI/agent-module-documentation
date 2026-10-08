# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Taxonomy** module (this is what the formatter renders), which is
  enabled on any standard Drupal site. The module itself declares no contrib
  dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hierarchical_term_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hierarchical_term_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hierarchical_term_formatter -y
```

There are no submodules and no configuration step. Once enabled, the
**Hierarchical Term Formatter** format becomes selectable in the **Format** column
of any **Manage display** page for entity-reference fields that target taxonomy
terms — see the [main page](../index.md) for how to configure it.
