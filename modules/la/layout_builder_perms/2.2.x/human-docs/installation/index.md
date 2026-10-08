# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) — enabled automatically as a dependency.

There are no contrib or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_perms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/layout_builder_perms -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_perms -y
```

The base module alone provides the *Access Layout Builder page* permission and the plugin
framework — **but no granular per‑operation restrictions**. To get fine‑grained control you must
also enable one or more submodules.

## Submodules — enable the granular permissions you need

Enable individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Global** | `layout_builder_perms_global` | Seven site‑wide operation permissions — create/edit/remove sections and create/config/remove/reorder blocks. |
| **Per content type** | `layout_builder_perms_node` | Per‑bundle node permissions, e.g. "add blocks on article nodes", "remove sections on page nodes". |
| **Per layout type (sections)** | `layout_builder_perms_layout_type` | Permissions scoped to a core layout type, e.g. "add layouts of type two‑column". |
| **Per entity type + bundle (sections)** | `layout_builder_perms_layout_per_bundle` | Section permissions scoped to a specific layout on a specific entity bundle. |
| **Block operations per layout** | `layout_builder_perms_block_operations_per_layout` | Block actions scoped to a layout, e.g. "add blocks in one‑column layouts". |
| **Block types per layout** | `layout_builder_perms_block_types_per_layout` | Restrict which inline block types may be placed in which layout. |

For example:

```bash
drush en layout_builder_perms_node -y
```

Each submodule requires the base module (already present once you've installed it). After
enabling, grant the new permissions at *People → Permissions* — see
[Configuration](../configuration/index.md).
