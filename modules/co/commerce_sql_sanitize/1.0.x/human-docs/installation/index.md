# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- **Drush** — the module extends Drush's `sql:sanitize` command, so Drush must be available
  in the environment where you run sanitization.
- A **Drupal Commerce** site (that is the data it knows how to scrub). The module itself
  declares no module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_sql_sanitize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_sql_sanitize -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

This is a development-time tool. In many setups you would only require it on development and
staging environments (where you sanitize copied databases), not necessarily on production —
though enabling it on production does no harm since it only acts when `sql:sanitize` runs.

## Enable the module

```bash
drush en commerce_sql_sanitize -y
```

## Verify it worked

Run a sanitize on a throwaway copy of a Commerce database and confirm the extra Commerce
operations run alongside core's:

```bash
drush sql:sanitize
```

You can inspect the sanitized database to confirm order emails/IPs and addresses are
scrubbed, logs and carts are removed, and stored payment methods and tax numbers are gone.
See the [overview](../index.md) for the full list of operations and the important
data-safety notes.
