# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The Universal Navigation content loads from **NYS‑hosted assets** (iFrames), so
  visitors' browsers need to be able to reach those NYS endpoints for the bars to
  render.

There are no module dependencies and no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/nys_unav -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nys_unav -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nys_unav -y
```

By default, once enabled the module automatically inserts the Universal Navigation
header and footer on every page. See [Configuration](../configuration/index.md) if
you want to adjust that or place the bars manually.

## Verify it worked

Load any front‑end page and confirm the New York State Universal Navigation bar
appears at the top and the Universal footer at the bottom. If they do not render,
check the settings form (see [Configuration](../configuration/index.md)) and confirm
browsers can reach the NYS‑hosted assets.
