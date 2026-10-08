# Installation

## Requirements

Twig Render This is deliberately lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.

There are no other module dependencies and no third‑party Composer or PHP library
requirements — it relies only on core's Twig.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_render_this -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twig_render_this -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_render_this -y
```

That is all it takes. The `|renderThis` Twig filter is available in every template
immediately — there is no configuration form and nothing else to switch on. See the
[overview](../index.md) for how to use the filter in your templates.
