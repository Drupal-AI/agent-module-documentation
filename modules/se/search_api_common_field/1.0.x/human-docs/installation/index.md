# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API** module (`search_api`) enabled — it is the only dependency,
  and Drupal enables it automatically as a dependency when you turn on this
  module.
- At least one Search API **index with two or more datasources** that share an
  identically-named property. Without cross-datasource shared properties there is
  nothing for a common field to merge (the *Add fields* form will offer no
  options).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_common_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_common_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_common_field -y
```

That's all the installation there is. The module has no settings page. To put it to
work, add a **Common field** to a multi-datasource index — see
[How to use it](../index.md#how-to-use-it) on the overview page.
