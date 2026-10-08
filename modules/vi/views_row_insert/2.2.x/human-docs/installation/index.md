# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), which Drupal enables as a dependency. This is
  the only dependency.
- No extra Composer libraries or PHP-version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_row_insert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_row_insert -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_row_insert -y
```

There are no submodules and no settings form. Once enabled, the **Row Insert**
style becomes available in the **Format** section of any view display. See the
[overview](../index.md) for how to configure it.
