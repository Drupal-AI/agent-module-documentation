# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (enabled by default on most sites) — Tailwind Grid is a
  Views style plugin.
- A **Tailwind-based theme**: the grid is rendered with Tailwind CSS classes, so
  those classes must be present in your theme's compiled CSS for the layout to take
  effect.

There are no PHP library or extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tailwind_grid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tailwind_grid -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tailwind_grid -y
```

## Verify it worked

Edit a View, open its **Format** setting, and confirm that **Tailwind Grid** now
appears as a style option. See [Configuration](../configuration/index.md) for how to
apply it and set the columns per breakpoint.
