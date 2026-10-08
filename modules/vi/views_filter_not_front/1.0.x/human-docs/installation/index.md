# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** (`views`) module, which is where the filter appears. It is
  enabled automatically as a dependency.
- The **Search API** module only if you want the matching search processor — the
  Views filter works without it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_filter_not_front -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_filter_not_front -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_filter_not_front -y
```

That is all the setup there is. Once enabled, add the **Exclude frontpage node**
filter to any view, or enable the **Exclude front page node** processor on a
Search API index — see the "How to use it" section of the
[overview](../index.md).

There are no submodules and no configuration page.
