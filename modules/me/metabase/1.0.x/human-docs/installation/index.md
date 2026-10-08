# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- A running **Metabase instance** with embedding enabled.
- A **Metabase secret key** (generated in Metabase's embedding settings), which you
  will store in Drupal — see [Configuration](../configuration/index.md).

There are no additional Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/metabase -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metabase -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metabase -y
```

## Verify it worked

After enabling, add the connection settings described in
[Configuration](../configuration/index.md), then go to **Structure → Block layout**
and confirm a **Metabase Dashboard** block type is available to place. Once placed
and configured, the dashboard should render in its region.
