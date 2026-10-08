# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third-party Composer or PHP library
requirements declared. You will, of course, need an external REST/OData API to
synchronise against, and credentials to authenticate to it.

This release is an early **alpha** (1.0.0-alpha22) — test it thoroughly before
relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/apisync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apisync -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apisync -y
```

There are no submodules. After enabling, configure the API connection, store the
credentials as a secret, and define your mappings — see
[How to use it](../index.md#how-to-use-it).
