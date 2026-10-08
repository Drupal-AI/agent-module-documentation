# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** (`field`), **User** (`user`) and **Views** (`views`) modules —
  all standard on a Drupal site and enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements. Note the project is a
young `1.0.x` release and is **not covered** by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/restaurant_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/restaurant_order -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en restaurant_order -y
```

## Verify it worked

After enabling and clearing caches (`drush cr`), the module's workflow paths (under
`/restaurant/…` and `/restaurant-order/…`) become available.
