# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Drupal core only — there are no third‑party Composer packages or PHP libraries
  to install.

> **Note:** this is a **beta** release and is **not covered by Drupal's security
> advisory policy**. Review and test it before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/reauthenticate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reauthenticate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reauthenticate -y
```

## Verify it worked

Open the module's settings form (see [Configuration](../configuration/index.md))
and add a path pattern such as `/user/*/edit*`. Then, as a logged‑in user, visit a
matching page — you should be prompted to re‑enter your password before the page
loads.
