# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`). The module only
  makes sense on 10.2+, since it exists to counteract the aggregate‑deletion
  behavior introduced in 10.1.
- No module dependencies and no Composer/PHP library requirements.

This branch is an **alpha** release, so verify it against your deploy and
cache‑rebuild workflow before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/css_js_agg_retention -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/css_js_agg_retention -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en css_js_agg_retention -y
```

## Verify it worked

Confirm CSS/JS aggregation is on (**Configuration → Development → Performance**),
load a page so aggregates are generated, and note the files under
`sites/*/files/css` and `sites/*/files/js`. Run a cache rebuild (`drush cr`) and
check that those directories are **not** emptied — recently generated aggregate
files should still be present. That is the behavior the module restores.
