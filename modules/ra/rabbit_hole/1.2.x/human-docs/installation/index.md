# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **No hard module dependencies** and no third‑party PHP libraries for the base
  module.
- The **Token** module is recommended if you want to use tokens in redirect
  targets (for example `[node:field_external_url]`). Some submodules also
  require the module for their entity type to exist — `rh_commerce` needs
  Commerce, `rh_group` needs Group, `rh_paragraphs_library` needs Paragraphs.

## Install with Composer

From the project root:

```bash
composer require drupal/rabbit_hole -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/rabbit_hole -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base framework:

```bash
drush en rabbit_hole -y
```

On its own the base module does nothing visible — it provides no way to act on
any entity type until you enable a submodule (below).

## Submodules — one per entity type

Rabbit Hole acts on an entity type only when its submodule is enabled. Each
submodule adds the "Rabbit Hole settings" tab to that entity type's forms and
registers its per‑type permissions. Enable only what you need with `drush en`:

| Submodule | Entity type it controls |
|-----------|-------------------------|
| `rh_node` | Content (nodes) |
| `rh_media` | Media items |
| `rh_taxonomy` | Taxonomy terms |
| `rh_user` | User profiles |
| `rh_file` | File entities |
| `rh_group` | Group entities (requires the Group module) |
| `rh_commerce` | Commerce products (requires Commerce) |
| `rh_paragraphs_library` | Paragraphs library items (requires Paragraphs) |

For example, to control node and taxonomy term pages:

```bash
drush en rh_node rh_taxonomy -y
```

Each submodule requires the base `rabbit_hole` module, which is already present
once you have installed it above. After enabling, head to
[Configuration](../configuration/index.md) to set behaviors and grant the
permissions.
