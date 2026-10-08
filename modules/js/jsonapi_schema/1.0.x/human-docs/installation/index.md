# Installation

## Requirements

- **Drupal 10.1 or newer, or Drupal 11** (`core_version_requirement:
  ^10.1 || ^11`).
- Core's **JSON:API** module (`jsonapi`) and **Serialization** module
  (`serialization`) enabled — these are the dependencies, and Drupal enables them
  automatically as dependencies when you turn on JSON:API Schema.

There are no third-party Composer or PHP library requirements. The module also
*suggests* **JSON:API Hypermedia** (`drupal/jsonapi_hypermedia` `^1.0`) — optional;
install it if you want schema links advertised inside JSON:API responses.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_schema -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsonapi_schema -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_schema -y
```

That's all — the module has no configuration. The schema endpoints appear
immediately under your JSON:API base path; see the
[overview](../index.md#how-to-use-it) for the available paths.
