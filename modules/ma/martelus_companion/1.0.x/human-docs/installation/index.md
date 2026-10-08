# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **paid subscription** to Vectorly AI from the
  [Martelus store](https://martelus.store/products/vectorly-ai) — the module is a
  connector to a hosted service and will not do anything useful without an active
  subscription and credentials.
- No other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/martelus_companion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/martelus_companion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en martelus_companion -y
```

## Verify it worked

At **Extend** (`/admin/modules`) confirm **Martelus Companion** is checked. Then open
the module's settings form to enter your Vectorly AI credentials — see
[Configuration](../configuration/index.md), and store the credentials securely as
described there.
