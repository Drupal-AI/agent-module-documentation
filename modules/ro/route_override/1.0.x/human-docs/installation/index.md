# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements.

Note that this is an **API / infrastructure module** — you install it because
another module needs it, or because you are writing custom code that will build on
it. It has no features you enable and use directly from the UI.

## Install with Composer

From the project root:

```bash
composer require drupal/route_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/route_override -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en route_override -y
```

## Verify it worked

There is nothing visible to check in the admin UI — the module adds no page,
route, or permission. It is working correctly if it enables without error and your
custom module (the one that registers a `route_override`‑tagged service) can
successfully override its target route. See "How to use it" on the
[overview page](../index.md).
