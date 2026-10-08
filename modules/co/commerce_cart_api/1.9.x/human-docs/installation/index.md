# Installation

## Requirements

- **Drupal 9.5, 10 or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **Drupal Commerce** (`drupal/commerce` ^2.13 || ^3) with the **Commerce Cart**
  submodule (`commerce_cart`) enabled.
- Core's **REST** (`rest`) and **Serialization** (`serialization`) modules — the
  cart resources are core REST resource plugins. All of these are enabled
  automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cart_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Commerce, REST and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_cart_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cart_api -y
```

On a normal install the module ships most of its cart resources already active with
JSON format and cookie authentication (the coupons resource is optional).

## Turn on the resources you need

Each cart endpoint is a standard core REST resource that does nothing until it is
enabled. You have three ways to enable one:

**With Drush (recommended):**

```bash
drush rest:enable commerce_cart_add --methods=POST --formats=json --authentication=cookie
drush cr
```

**With a REST resource config entity** (`rest.resource.commerce_cart_add`):

```yaml
id: commerce_cart_add
plugin_id: commerce_cart_add
granularity: resource
configuration:
  methods: [POST]
  formats: [json]
  authentication: [cookie]
status: true
```

**By script** — create the same `RestResourceConfig` entity in PHP.

Repeat for whichever of the eight resources your front end needs (see the resource
table on the [overview page](../index.md#how-to-use-it)).

## Next step

This is an API with no admin UI. For the endpoints, request/response shapes, access
model and the anonymous **cart token** mode, see
[How to use it](../index.md#how-to-use-it) on the overview page and the agent docs.
