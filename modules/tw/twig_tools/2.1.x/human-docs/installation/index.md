# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies, no third‑party libraries, and no PHP
extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/twig_tools -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_tools -y
```

There are no submodules and no configuration. Once enabled, all of the Twig
filters are available in every template site‑wide — see the
[overview](../index.md) for examples. You may want to rebuild caches
(`drush cr`) so the new Twig extensions are picked up.
