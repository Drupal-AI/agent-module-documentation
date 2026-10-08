# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`) and **PHP 8.3 or
  newer**.
- **Drush 13+** for the `emulsify_tools:bake` child-theme generator and the favicon
  deployment commands. The module is suggested with Drush 13+ for these; the Twig
  helpers, tags, and namespaces work without Drush.
- The favicon commands specifically expect the **Emulsify Drupal 7.x** companion
  theme; on a site without an Emulsify theme they simply have nothing to act on.

There are no other module dependencies and no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/emulsify_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/emulsify_tools -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en emulsify_tools -y
```

You can also enable it from **Extend** (`/admin/modules`).

## What happens next

The Twig helpers (`bem()`, `add_attributes()`, `{% switch %}`) and theme namespaces
are available to your themes immediately — no configuration required. See the
[overview](../index.md#how-to-use-it) for how to use each helper, declare namespaces,
generate a child theme, and run the favicon commands.
