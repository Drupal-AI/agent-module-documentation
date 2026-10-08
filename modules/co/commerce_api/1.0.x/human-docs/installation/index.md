# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **Drupal Commerce** — the `commerce` and `commerce_cart` modules.
- Core's **JSON:API** and **Serialization** modules.
- Two contrib modules Commerce API builds on:
  [`jsonapi_resources`](https://www.drupal.org/project/jsonapi_resources) and
  [`jsonapi_hypermedia`](https://www.drupal.org/project/jsonapi_hypermedia).

Composer pulls the contrib dependencies in automatically; the core modules are
enabled as dependencies when you enable Commerce API.

The current release is a release candidate (`1.0.0-rc5`).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_api -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
pull in and update Commerce, `jsonapi_resources`, `jsonapi_hypermedia`, and the
other shared dependencies together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_api -y
```

Enabling Commerce API also enables its dependencies (JSON:API, Serialization,
`jsonapi_resources`, `jsonapi_hypermedia`, and the required Commerce modules if
they are not already on). There are no submodules and no configuration form.

## Verify it worked

With the module enabled, request **`/jsonapi/current-store`** (under your site's
JSON:API prefix). A JSON:API document describing the current store confirms the
endpoints are live. From there you can build cart and checkout requests from your
front end — see the cart-token notes in the [overview](../index.md).
