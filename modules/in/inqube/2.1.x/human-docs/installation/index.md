# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An **Elasticsearch cluster** that your site can reach — this is the search
  backend the generated queries run against. Inqube itself lists no Composer
  package requirements, but a working Elasticsearch setup is what makes it useful.
- Drupal's **Views** module (core), since the query builder is driven from Views.

## Install with Composer

From the project root:

```bash
composer require drupal/inqube -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inqube -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inqube -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`). Because Inqube
provides base classes rather than a UI, there is no settings page to visit —
verification really happens in the code that builds on it and in whether your
Elasticsearch cluster answers the generated queries. See the
[overview](../index.md) for how the module is meant to be used.
