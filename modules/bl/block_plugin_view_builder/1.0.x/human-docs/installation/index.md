# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/block_plugin_view_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_plugin_view_builder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_plugin_view_builder -y
```

There is nothing to configure. Enabling the module makes its render helper
available to your own module and theme code — see
[How to use it](../index.md#how-to-use-it) and the
[`agent/`](../agent/start.md) docs for details.
