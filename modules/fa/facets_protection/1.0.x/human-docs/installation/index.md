# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Facets** module (`drupal/facets`) — this module protects facets it
  provides and cannot work without it. Composer pulls it in with the command below.

There are no third‑party PHP library requirements. This project **is covered by
Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_protection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Facets module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_protection -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_protection -y
```

This also ensures the Facets module is enabled.

## Verify it worked

After enabling, review the module's settings form and its permissions (see
[Configuration](../configuration/index.md)). To confirm the protection is active,
open a facet link with a missing or expired token and check that you get the
minimal blocking page and an HTTP **410 ("Gone")** response, rather than the full
filtered results.
