# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Only core APIs (Condition, Context, Form) — there are no other module dependencies and no
  third‑party Composer or PHP libraries.

Conditions Helper is a library for other modules, so it is most often installed automatically as
a dependency of a module that builds on it. You can also install it directly.

## Install with Composer

From the project root:

```bash
composer require drupal/conditions_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/conditions_helper -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en conditions_helper -y
```

There is nothing to configure — enabling it simply makes its services and base classes available
to other code (see [How to use it](../index.md#how-to-use-it)).

There are no submodules.
