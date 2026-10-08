# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No contrib module dependencies, third‑party Composer packages, or external
  libraries — it builds on Drupal core's configuration system.

> **Security coverage:** this project is **not covered** by Drupal's security
> advisory policy at the time of writing, and it is minimally maintained. Factor
> that into your decision for production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/contentishconfig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contentishconfig -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contentishconfig -y
```

## Verify it worked

Mark a low‑risk configuration entity as contentish (see "How to use it" in the
[overview](../index.md)), then run a configuration export/status check — for
example `drush config:status` — and confirm that the marked configuration is no
longer reported as something to export or import. That shows the module is
excluding it from sync as intended.
