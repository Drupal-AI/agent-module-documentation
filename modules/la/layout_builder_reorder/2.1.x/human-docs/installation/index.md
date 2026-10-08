# Installation

## Requirements

Layout Builder Reorder needs:

- **Drupal 11.4+ or 12** (`core_version_requirement: ^11.4 || ^12`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_reorder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_reorder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_reorder -y
```

That's all. There's no configuration and no new permission — open any
Layout Builder layout and the **Move up** / **Move down** links appear on each
section. See [How to use it](../index.md#how-to-use-it).
