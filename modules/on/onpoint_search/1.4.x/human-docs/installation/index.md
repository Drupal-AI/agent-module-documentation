# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No other contrib modules and no third‑party PHP libraries.
- An **OnPoint Search account** with an API key (a free trial is available at
  [search.onpointsuite.com](https://search.onpointsuite.com/)).

> **Maintenance status:** this project is *minimally maintained* (maintenance
> fixes only), and this branch is an alpha release. It works, but weigh that
> before relying on it for a critical site.

## Install with Composer

From the project root:

```bash
composer require drupal/onpoint_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/onpoint_search -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en onpoint_search -y
```

The project also includes an `onpoint_search_d8` submodule; enable it only if your
setup calls for it:

```bash
drush en onpoint_search_d8 -y
```

## Verify it worked

Confirm the module is enabled on the **Extend** page, then open its settings form
(`onpoint_search.settings`) and enter your OnPoint API key as described in
[Configuration](../configuration/index.md). Once the key is saved and OnPoint has
crawled your site, run a search and confirm OnPoint‑powered results come back.
