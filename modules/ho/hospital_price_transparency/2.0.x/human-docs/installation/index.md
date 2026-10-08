# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Core's **File** module (`file`) and **Path Alias** module (`path_alias`) — both
  ship with Drupal core and are enabled automatically as dependencies. File
  handles the uploaded charges file; Path Alias generates the CMS‑mandated public
  path.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hospital_price_transparency -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hospital_price_transparency -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hospital_price_transparency -y
```

Drupal will enable the File and Path Alias dependencies for you if they aren't
already on.

## Upgrading from v1 to v2

If you're moving from the 1.x branch, the upgrade is designed to be
straightforward with no risk of data loss — but review the module's own
documentation for the handful of things worth checking before you upgrade.

## Verify it worked

Log in as an administrator. You should be able to create a new **HPT** entity,
upload a charges file, and — after filling in the EIN and hospital name and
publishing — visit the entity's URL and see the file's contents served directly.
Next, review the module settings and permissions in
[Configuration](../configuration/index.md).
