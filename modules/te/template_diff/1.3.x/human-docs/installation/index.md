# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Drush**, since the module's whole feature is a Drush command
  (`template_diff:show`).
- No module dependencies of its own, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/template_diff -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/template_diff -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en template_diff -y
```

This is a development aid, so it is usually best enabled in a development
environment rather than on production.

## Verify it worked

Run the command against a template you know is overridden in your theme, for example:

```bash
drush template_diff:show views-view
```

You should get a diff between the active theme's `views-view` template and its base
theme's version. See the [main guide](../index.md) for more command examples.
