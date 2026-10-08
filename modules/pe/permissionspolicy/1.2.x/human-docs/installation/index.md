# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **`gapple/structured-fields`** PHP library (version `^2.0`), which the module
  uses to build the correctly formatted header. Composer installs it automatically
  when you require the module — which is why you should install with Composer rather
  than downloading the module by hand.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/permissionspolicy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will pull in `gapple/structured-fields` at the same
time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/permissionspolicy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permissionspolicy -y
```

You can also enable it from **Extend** (`/admin/modules`).

## What happens next

The module is enabled with an **empty feature set**, so it sends no header yet — your
site behaves exactly as before until you add features. Head to
[Configuration](../configuration/index.md) to choose which browser features to
control.
