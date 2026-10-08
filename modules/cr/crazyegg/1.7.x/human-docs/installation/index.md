# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12**
  (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
- No dependencies beyond Drupal core, and no third‑party PHP libraries.
- A **Crazy Egg account**, so you have a numeric account number to enter. (The
  module injects the tracking script; you view the resulting heatmaps and
  recordings in Crazy Egg itself.)

## Install with Composer

From the project root:

```bash
composer require drupal/crazyegg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/crazyegg -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crazyegg -y
```

The module ships no submodules.

## Grant the permission

Assign the **Administer Crazy Egg** permission (machine name
`administer crazy egg`) to the roles that should manage tracking. This controls
who can open the settings form; it does not affect whether a given visitor is
tracked (that is governed by the path and role settings on the form).

## Verify it worked

Log in as an administrator and go to **Configuration → System → Crazy Egg**
(`/admin/config/system/crazyegg`). You should see the settings form. Enter your
account number and save — see [Configuration](../configuration/index.md).
