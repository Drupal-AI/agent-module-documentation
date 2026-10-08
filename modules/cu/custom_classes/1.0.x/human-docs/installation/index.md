# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Path alias** module (`path_alias`) — Drupal enables it automatically as
  a dependency when you turn on Custom Classes.
- No third‑party Composer or PHP library requirements.

Note: the 1.0.x branch is an **alpha** release and the project is currently
*seeking a new maintainer*, so test it thoroughly before using it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_classes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_classes -y
```

## Verify it worked

After enabling, grant the **`administer custom_classes configuration`** permission
to a trusted role, then add a rule that puts a class on a known form (see
[How to use it](../index.md#how-to-use-it)). Load that form and inspect the element
in your browser's dev tools — your class should appear in the rendered markup.
