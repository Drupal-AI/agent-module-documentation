# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules only — **Text**, **Entity Reference** (`entity`), **File**,
  **User**, **Node**, **Path**, **Options**, and **File Link** (`file_link`).
  Drupal enables these automatically as dependencies.

There are no third-party Composer or PHP library requirements, and no live Apigee
connection is needed for the `apidoc` node type to work.

## Install with Composer

From the project root:

```bash
composer require drupal/apigee_api_catalog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apigee_api_catalog -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apigee_api_catalog -y
```

Enabling it installs the `apidoc` node type and its fields. You can then start
creating API documentation nodes — see [How to use it](../index.md#how-to-use-it).

## Submodules — enable only what you need

Three optional, **experimental** submodules extend the catalogue beyond OpenAPI.
Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AsyncAPI Doc** | `apigee_asyncapi_doc` | Document event-driven APIs with AsyncAPI specs. |
| **GraphQL Doc** | `apigee_graphql_doc` | Document GraphQL APIs. |
| **Free-form Doc** | `apigee_freeform_doc` | Publish hand-written, free-form documentation alongside generated specs. |

For example:

```bash
drush en apigee_graphql_doc -y
```

Each submodule requires the base Apigee API Catalog module, which is already
present once you have installed it above. Because they are marked experimental,
test them before relying on them in production.
