# Installation

## Requirements

- **Drupal 10.6 or 11.2+** (`core_version_requirement: ^10.6 || ^11.2`).
- Drupal's **recipe** system, which is part of core on these versions — this
  module reacts to core's `RecipeAppliedEvent`, so no contrib dependency is
  needed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/recipe_config_translation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recipe_config_translation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recipe_config_translation -y
```

That is all the site-side setup there is. There is no configuration form and no
admin page to visit — the module simply starts listening for recipe-apply events.

## Verify it worked

Apply a recipe that ships language files (see "How to use it" in the
[overview](../index.md)) on a site with the matching language installed, then
inspect the config override storage for that language — for example, confirm the
German override of `system.site` now holds your translated site name. If you are
testing your own recipe, the kernel-test fixtures bundled with the module make a
good template for an automated check.
