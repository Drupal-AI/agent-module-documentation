# Installation

## Requirements

Random String Generator is self‑contained:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- No other modules, third‑party Composer libraries, or PHP extensions are required.

## Install with Composer

From the project root:

```bash
composer require drupal/rsg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rsg -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rsg -y
```

## Verify it worked

Log in as an administrator and confirm the module is enabled at **Extend**
(`/admin/modules`). To confirm it functions, visit one of the generator routes such
as `/random/string/10` and check that a random 10‑character value comes back, or
call the `random.string.generator` service from custom code.
