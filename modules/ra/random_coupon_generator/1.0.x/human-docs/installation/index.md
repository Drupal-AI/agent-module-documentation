# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **`wotzebra/unique-codes`** PHP package, which provides the code-generation
  algorithm. You don't install this by hand — Composer pulls it in automatically
  as a dependency of the module (which is exactly why you should install with
  Composer rather than by downloading a zip).
- No other Drupal modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/random_coupon_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and ensures `wotzebra/unique-codes` is fetched.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/random_coupon_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en random_coupon_generator -y
```

The module provides its own permission for reaching the generator; grant it to
the roles that should be allowed to create coupon codes (see
[Configuration](../configuration/index.md)).

## Verify it worked

Go to **Configuration → System → Random coupon generator**. You should see the
**Settings** and **Generate coupons** screens. Open the generator, produce a
small test batch (say, 5 codes shown on the page), and confirm you get five
distinct random codes back.
