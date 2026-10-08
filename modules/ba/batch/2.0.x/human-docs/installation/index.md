# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Awareness** module (`awareness`), which Drupal enables as a dependency.

This is an **alpha** release (2.0.0‑alpha9) — pin your version and test before
using it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/batch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/batch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en batch -y
```

There is nothing to configure — use the helpers from your own code. See
[How to use it](../index.md#how-to-use-it).
