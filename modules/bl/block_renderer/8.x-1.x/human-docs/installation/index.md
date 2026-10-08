# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other module dependencies and no third-party PHP libraries.

> **Note:** The current release is an alpha (`8.x-1.0-alpha6`). Test it in a
> non-production environment before you rely on it.

## Install with Composer

From the project root:

```bash
composer require drupal/block_renderer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_renderer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_renderer -y
```

There is nothing to configure. Enabling the module makes its rendering utility
available to your own module and theme code — see
[How to use it](../index.md#how-to-use-it) and the
[`agent/`](../agent/start.md) docs for details.
