# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- **PHP 8.1** or newer.
- Core's **Block** module (`block`), which Drupal enables as a dependency. This is
  the only required dependency.
- Optionally, the **Token** module — if installed, you can use tokens inside a
  block's cache tags. It is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/blocache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/blocache -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blocache -y
```

There are no submodules and no settings form. Once enabled, grant the **Administer
block cache** permission to the roles that should tune block caching, then edit any
block to find the new **Cache Settings** section. See
[Configuration](../configuration/index.md) for how to use it.
