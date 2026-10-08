# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No dependent modules, no PHP libraries, and no third‑party Composer packages —
  dependencies are core only.
- A **Google Programmable Search Engine** (Custom Search) that you create on Google's
  side. You will need its ID (the "CX" code) for the settings form.

Because the results page claims the `/search` path, the module's documentation
recommends that you **uninstall core's Search module** on sites where it is enabled,
to avoid a collision.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_gse_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_gse_search -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_gse_search -y
```

## Verify it worked

After enabling, visit **Configuration → Search and metadata → Simple GSE Search**.
If the settings form loads, the module is installed. You still need to enter your
search engine ID and place the search block before search works end to end — see
[Configuration](../configuration/index.md).
