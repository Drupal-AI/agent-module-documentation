# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core modules it generates configuration for: **Node** (`node`), **Field**
  (`field`), **Taxonomy** (`taxonomy`), **Block Content** (`block_content`),
  **Views** (`views`), and **Menu Link Content** (`menu_link_content`).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`), configured with
  a working AI provider — this is what generates the configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/aia -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aia -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aia -y
```

This ensures the core dependencies and the `ai` module are enabled too. Then
grant `administer aia` only to trusted site builders / administrators.

> **Tip:** because AIA writes real configuration, try it first on a development or
> staging site.
