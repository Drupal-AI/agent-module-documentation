# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** (`node`) and **Path Alias** (`path_alias`) modules, both enabled
  on a standard Drupal site.

No contributed‑module dependencies and no third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/node_rss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_rss -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_rss -y
```

## Post‑installation

Grant the **node.view all rss feeds** permission at **People → Permissions**
(`/admin/people/permissions`) to any role that should read the feeds — including
**Anonymous user** if the feeds should be public. Without this permission the `/rss`
paths are not viewable.

## Verify it worked

Append `/rss` to an existing node's URL — for example `/node/1/rss` — while logged
in as a user who has the permission. You should receive an RSS rendering of the node
rather than the normal HTML page.
