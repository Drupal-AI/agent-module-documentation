# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/normalize_and_validate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/normalize_and_validate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en normalize_and_validate -y
```

## Verify it worked

There is no admin page to check — this is a developer library. It is working once
it is enabled and its normalization/validation helpers are available to any code
that depends on it. If you installed it as a dependency of another module, that
module's setup instructions cover what happens next.
