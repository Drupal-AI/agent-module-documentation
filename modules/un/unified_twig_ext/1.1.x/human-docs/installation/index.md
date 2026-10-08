# Installation

## Requirements

- **Drupal 9.3, 10 or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No third-party PHP libraries and no other module dependencies.
- A **theme** that follows the `_twig-components` layout (typically a Pattern
  Lab-based theme) set as your site's default theme — this is what the module
  reads from.

## Install with Composer

From the project root:

```bash
composer require drupal/unified_twig_ext -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/unified_twig_ext -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en unified_twig_ext -y
```

The module ships no submodules and has no configuration. After enabling it, add
your Twig extension files to the default theme's `_twig-components/` folders and
run `drush cr` so they are discovered — see
[How to use it](../index.md#how-to-use-it) for the folder layout.
