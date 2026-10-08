# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Default Content** (`default_content`) and **Serialization**
  (`serialization`) modules — used to capture and serialize content into the
  recipe. Both are enabled automatically as dependencies.
- Because the module is under active development, install it on a development or
  staging copy of your site before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/ratatouille -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ratatouille -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ratatouille -y
```

Drupal will enable Default Content and Serialization alongside it if they are not
already on.

## Verify it worked

Once enabled, open the Ratatouille recipe-export wizard and confirm it loads and
lists your site's content and configuration for selection. From there, follow the
wizard steps described in [How to use it](../index.md#how-to-use-it) to generate a
recipe.
