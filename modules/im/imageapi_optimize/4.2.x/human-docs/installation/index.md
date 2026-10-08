# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no contrib dependencies
  for the base module itself.
- **At least one processor module.** This module is the pipeline *framework* — the
  optimizers that actually compress images ship as separate processor plugins
  (companion projects such as reSmush.it, or modules that wrap local binaries like
  jpegoptim and optipng). Without one, your pipelines will have no processors to
  add. Install whichever suits your hosting: a remote service needs no server
  binaries, while local‑binary processors require those tools installed on the
  server.

## Install with Composer

From the project root:

```bash
composer require drupal/imageapi_optimize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Add your chosen processor project the same way, for example
`composer require drupal/imageapi_optimize_resmushit -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imageapi_optimize -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imageapi_optimize -y
```

Enable your processor module(s) the same way. The base module ships **no
submodules** of its own.

## Grant the admin permission

Managing pipelines is gated by the **Administer imageapi optimize pipelines**
permission. Grant it to trusted roles, for example:

```bash
drush role:perm:add site_admin 'administer imageapi optimize pipelines'
```

## Next steps

Head to **Configuration → Media → Image Optimize pipelines** to build your first
pipeline — see [Configuration](../configuration/index.md).
