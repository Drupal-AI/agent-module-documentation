# Installation

## Requirements

Snowflakes is deliberately tiny. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

There are no other module dependencies, no PHP extension requirements, and no
third‑party libraries — the snow is pure CSS.

## Install with Composer

From the project root:

```bash
composer require drupal/snowflakes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/snowflakes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en snowflakes -y
```

## Next step

Once enabled, turn the effect on and adjust its appearance — see
[Configuration](../configuration/index.md).
