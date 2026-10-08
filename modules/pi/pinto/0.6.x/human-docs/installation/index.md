# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.2 or higher** — this is a hard requirement; Pinto's typed component classes
  rely on modern PHP features.
- The **Pinto PHP library**, which the Drupal module depends on and Composer installs
  automatically. (The library is developed independently of the Drupal integration.)

## Install with Composer

Always install this module with Composer so the underlying Pinto PHP library is
pulled in as a dependency:

```bash
composer require drupal/pinto -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pinto -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pinto -y
```

## Verify it worked

Because Pinto is a developer framework with no UI, the best confirmation is in code:
after enabling, a Pinto component class you define and invoke should render through
Drupal's theming without errors. Clear the cache (`drush cr`) after adding new
component classes so Drupal picks them up. For a full worked example, see the
official documentation at <https://pinto.docs.contrib.social/>.

> **A note on versioning:** Pinto has adopted "ZeroVer" (its version numbers stay
> below 1.0). Despite the pre-1.0 numbering, the project reports strong test
> coverage and static analysis; still, review it as you would any pre-stable
> dependency before relying on it in production.
