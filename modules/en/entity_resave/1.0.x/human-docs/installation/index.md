# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9.0 || ^10`).
- No module dependencies, no third‑party Composer packages, and no PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_resave -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_resave -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_resave -y
```

## Verify it worked

Visit `/admin/entity_resave/resave-node` — if the node resave form loads with a
content‑type selector, the module is installed.

> **Before you use it in production**, review the security warning in the
> [overview](../index.md): the resave forms are gated only by the *access content*
> permission (granted to anonymous by default). Restrict the routes with a real
> administrative permission before exposing them on a live site.
