# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), which is part of a standard install and is enabled
  automatically as a dependency.

There are no third‑party libraries or special PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_custom_cache_tag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/views_custom_cache_tag -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_custom_cache_tag -y
```

This enables `views` as a dependency if it isn't already on.

## Optional demo submodule

The project bundles a **Views Custom Cache Tag Demo** submodule
(`views_custom_cache_tag_demo`) that installs example content types and views to show the
plugin in action. It is a **demonstration only** — enable it on a scratch/dev site if you
want to explore, but do not enable it on production:

```bash
drush en views_custom_cache_tag_demo -y
```

## After enabling

The new **Custom Tag based** caching option is now available in the Views UI. Edit a view and
choose it under **Advanced → Caching** — see [How to use it](../index.md#how-to-use-it).
