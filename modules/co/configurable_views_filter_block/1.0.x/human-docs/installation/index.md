# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — Drupal enables it automatically as a
  dependency. You'll also need at least one view whose display has an exposed form
  set to show in a block.
- Optionally, **Better Exposed Filters** (`drupal/better_exposed_filters`) — a
  suggested (not required) companion that lets you restyle the exposed form with
  links, checkboxes, and other widgets.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/configurable_views_filter_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/configurable_views_filter_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en configurable_views_filter_block -y
```

## Next steps

There is no settings page. Before the block is available, make sure your view
display has **Advanced → Exposed form in block** set to **Yes**, then place and
configure the block from **Structure → Block layout**. See
[How to use it](../index.md#how-to-use-it) in the overview for the full flow.
