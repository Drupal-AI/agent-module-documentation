# Installation

> **Development only.** This module mass-creates Commerce content. Never enable or
> run it on a production site.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** — the `commerce`, `commerce_order` and `commerce_product`
  modules.
- **Devel Generate** (`devel_generate`), part of the Devel project.

Drupal will enable these dependencies for you when you enable the module, provided
Commerce and Devel are already installed via Composer. There are no third-party PHP
library requirements, and the module is covered by Drupal's security advisory
policy.

## Install with Composer

From the project root:

```bash
composer require drupal/devel_generate_commerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — useful here since it pulls in Devel and relies on
Commerce being present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/devel_generate_commerce -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en devel_generate_commerce -y
```

## Grant the permission

This module provides its own permission for running the generator. Under **People →
Permissions**, grant it only to developer roles, and only on non-production
environments.

## Verify it worked

Go to **Configuration → Development → Generate → Generate commerce**
(`/admin/config/development/generate/commerce`). The Commerce generation form
should appear alongside the other Devel Generate tools. Run a small generation on a
dev site and confirm the products/orders appear in Commerce.
