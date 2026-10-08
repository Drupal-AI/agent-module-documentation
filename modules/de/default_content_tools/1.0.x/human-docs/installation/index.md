# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Default Content API** (included in core) — used automatically.
- **Optional but recommended:** the contributed
  [Default Content](https://www.drupal.org/project/default_content) module, which
  enhances what Default Content Tools can manage, and
  [Recipe Tracker](https://www.drupal.org/project/recipe_tracker) for a fuller
  log of applied recipes.

There are no PHP library or third‑party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/default_content_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/default_content_tools -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en default_content_tools -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content Authoring →
Default Content Tools**. If the settings page loads, the module is active and
ready to configure — see [Configuration](../configuration/index.md).

> **Tip:** If you want to *suppress* default‑content imports, enable and
> configure this module **before** installing the modules or applying the recipes
> whose content you want to skip. Once content has already been imported, use the
> deletion feature instead.
