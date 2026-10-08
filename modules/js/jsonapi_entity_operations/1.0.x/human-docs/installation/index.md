# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **JSON:API** (`jsonapi`) module — the link points at JSON:API resources,
  so this must be enabled. Drupal enables it as a dependency automatically.

There are no third‑party Composer packages or external libraries to install.

> **Not covered by the security advisory policy.** This project isn't tracked
> through Drupal's official security process — worth weighing before using it on
> a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_entity_operations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_entity_operations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_entity_operations -y
```

This also enables core JSON:API if it isn't already on.

## Verify it worked

By default the module targets content nodes, so grant the viewing permission (see
[Configuration](../configuration/index.md)) and then open the **Content** page
(`/admin/content`). In a node's operations dropbutton you should now see **See
JSON:API resource** — clicking it opens that node's JSON:API output in a new tab.
