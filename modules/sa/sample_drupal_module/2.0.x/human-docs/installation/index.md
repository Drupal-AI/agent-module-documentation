# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).

There are no module dependencies, no PHP library requirements and no third‑party
Composer requirements. Note this project is **not covered by Drupal's security
advisory policy** — though, being an empty skeleton, it has no code to secure.

## Install with Composer

From the project root:

```bash
composer require drupal/sample_drupal_module -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sample_drupal_module -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sample_drupal_module -y
```

That is all there is to it — there is no configuration. To confirm it uninstalls
cleanly (a common reason people use a skeleton like this), you can disable it
again with `drush pmu sample_drupal_module -y` and check that no residual
configuration remains.
