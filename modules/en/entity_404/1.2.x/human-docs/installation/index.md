# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No third-party libraries and no other contrib dependencies.

> **Heads up:** this project is minimally maintained (maintenance fixes only),
> though it is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_404 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_404 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_404 -y
```

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`). Then, as
a functional check, view an entity that fails one of the checks (for example one
whose type/bundle has no full view mode configured) — you should get the site's
404 page rather than the entity. See [Configuration](../configuration/index.md) to
adjust which checks are active.
