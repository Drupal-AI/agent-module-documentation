# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- No module dependencies and no third‑party PHP or JavaScript library
  requirements — the module ships its own small script.

## Install with Composer

From the project root:

```bash
composer require drupal/drowl_trademark -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drowl_trademark -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drowl_trademark -y
```

## Verify it worked

Once enabled, open the module's settings form and add a word or two to the list
(see [Configuration](../configuration/index.md)). Then visit a front‑end page that
contains one of those words — it should now show a superscript ® immediately after
it.
