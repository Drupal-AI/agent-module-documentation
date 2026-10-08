# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** (`node`) and **Views** (`views`) modules — Drupal enables them
  automatically as dependencies when you turn on this module. (Both are part of the
  standard install.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_node_access_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_node_access_filter -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_node_access_filter -y
```

Enabling the module flags Drupal to rebuild node access grants (so the edit grants
it needs are present). If your site prompts you to rebuild permissions, or you want
to be certain, you can trigger it manually:

```bash
drush php:eval "node_access_rebuild();"
```

There is no configuration page. Next, add the **Editable** filter to a view — see
the [main page](../index.md#how-to-use-it).
