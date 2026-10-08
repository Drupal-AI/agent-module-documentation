# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — it is enabled by default on most
  sites, and Drupal enables it automatically as a dependency.
- The **`andileco/eval-math`** PHP library (`^3.0.1`), which evaluates the formulas.
  It is declared in the module's `composer.json`, so Composer installs it for you.

## Install with Composer

From the project root:

```bash
composer require drupal/views_simple_math_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and pulls in the `andileco/eval-math` library the module
depends on. Installing the module by downloading it manually will **not** bring in
that library, so Composer is the recommended route.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_simple_math_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_simple_math_field -y
```

There are no submodules. Once enabled, the **Global: Simple Math Field** field and
its matching sort handler become available inside any view — see
[the overview](../index.md#how-to-use-it) for how to add and configure it.
