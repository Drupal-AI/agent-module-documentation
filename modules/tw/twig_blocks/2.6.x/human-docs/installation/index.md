# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- No other modules, PHP extensions, or third-party libraries — Twig Blocks depends
  only on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twig_blocks -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_blocks -y
```

That is all — the `render_block()` Twig function is immediately available in your
templates, and the `twig_blocks.block_view_builder` service is available to custom
code. There is nothing to configure. See
[How to use it](../index.md#how-to-use-it) on the overview page.
