# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).

There are no other module dependencies. The theme you want to force must, of
course, be installed on the site.

## Install with Composer

From the project root:

```bash
composer require drupal/force_render_theme -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/force_render_theme -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en force_render_theme -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage display** and pick a
view mode. You should see a **Theme settings** section where you can choose the
theme to render that display with. If it appears, the module is working — see the
[main guide](../index.md) for how to use it.
