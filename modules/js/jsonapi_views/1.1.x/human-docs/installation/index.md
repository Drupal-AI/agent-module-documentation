# Installation

## Requirements

- **Drupal 8.8 or newer** (`core_version_requirement: >=8.8`), including 9, 10,
  and 11.
- Core's **Views** module (`views`) enabled.
- Core's **JSON:API** module enabled (it provides the `/jsonapi` base path the
  resources live under).
- The contributed **JSON:API Resources** module (`jsonapi_resources` version 1.x)
  — this is a hard dependency and Composer pulls it in for you.

There are no additional third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the required `jsonapi_resources` module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsonapi_views -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_views -y
```

Drupal enables `views` and `jsonapi_resources` as dependencies if they aren't
already on. Make sure core's **JSON:API** module is enabled too
(`drush en jsonapi -y`).

There are **no submodules** and no configuration step. Every view display is
exposed immediately at `/jsonapi/views/{viewId}/{displayId}` — see
[How to use it](../index.md#how-to-use-it), including how to keep a display
internal.
