# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).

The module has no other module dependencies and no third-party Composer library
requirements. Note the current release is `3.0.0-beta1`, a **beta** — test it
before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_anchors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_anchors -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_anchors -y
```

After enabling, review the module's settings and grant the
`administer automatic anchors` and `show automatic anchor links` permissions as
needed — see the "How to use it" section of the [overview](../index.md).
