# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Layout Builder** (`layout_builder`) and **Layout Discovery**
  (`layout_discovery`) modules — both are dependencies and Drupal enables them
  automatically when you turn on CSS Grid.
- No third‑party PHP or Composer library requirements.

This branch is a **beta** release, so test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/css_grid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/css_grid -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en css_grid -y
```

Drupal enables the Layout Builder and Layout Discovery dependencies automatically
if they aren't already on.

## Verify it worked

Enable Layout Builder for a content type, edit its layout, and **add a section**.
**CSS Grid** should now appear as one of the available layout options. See the
[main guide](../index.md#how-to-use-it) for the full walkthrough.
