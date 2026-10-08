# Installation

## Requirements

Condition path is lightweight and has no third‑party dependencies:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**, with the `mbstring` extension (standard on almost every
  Drupal host).

It builds on core's condition system, so there are no contrib module
dependencies to install.

## Install with Composer

From the project root:

```bash
composer require drupal/condition_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/condition_path -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en condition_path -y
```

That's all it takes. The new **Pages (include and exclude)** condition is now
available wherever Drupal shows visibility settings — see
[How to use it](../index.md#how-to-use-it) for the path syntax. There is no
configuration page and no submodules.
