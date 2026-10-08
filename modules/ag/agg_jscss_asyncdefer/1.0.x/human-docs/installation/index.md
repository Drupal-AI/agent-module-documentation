# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

The module lists no other module dependencies and no third-party Composer or PHP
libraries. Because it works with Drupal's asset aggregation, you will get the most
out of it with CSS/JS aggregation enabled (**Configuration → Development →
Performance**).

## Install with Composer

From the project root:

```bash
composer require drupal/agg_jscss_asyncdefer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/agg_jscss_asyncdefer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en agg_jscss_asyncdefer -y
```

Once enabled, apply `async`/`defer` carefully and test the results — see
[How to use it](../index.md#how-to-use-it) on the overview page, and heed the
warning there about ordering and intermittent breakage.
