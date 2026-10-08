# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9`), including Drupal 10 and
  11.
- Core's **Node** module (`node`) and core's **JSON:API** module (`jsonapi`), both
  enabled — these are the module's dependencies, and JSON:API is what it extends.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_node_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsonapi_node_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_node_preview -y
```

Drupal enables JSON:API (and Node) at the same time if they aren't already on.
There are no submodules and nothing to configure — the `/preview` endpoints are
added to your JSON:API node resources automatically. See the **How to use it**
section of the [overview](../index.md) to start requesting previews.

> **Tip:** if you don't see the new route, rebuild the router cache with
> `drush cr` so the generated preview routes are registered.
