# Installation

## Requirements

CTools is self-contained and has no third-party dependencies. It needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).

There are no other module dependencies, no PHP library requirements, and no
Composer requirements beyond core itself.

## Install with Composer

From the project root:

```bash
composer require drupal/ctools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. In practice you will often find CTools already present,
because another module (such as Panels or Page Manager) required it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ctools -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ctools -y
```

CTools has no required configuration and no settings form — once enabled, its APIs
and plugins are available to the modules that use them.

## Submodules — enable only what you need

CTools ships three optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **CTools Block** | `ctools_block` | An "entity field" block that renders any single field of an entity. |
| **CTools Entity Mask** | `ctools_entity_mask` | Lets a custom entity type borrow another type's fields and display (a developer tool, no UI of its own). |
| **CTools Views** | `ctools_views` | Exposes a Views display as a configurable block with row, offset, and pager overrides. |

For example, to enable the Views block enhancements:

```bash
drush en ctools_views -y
```

Each submodule requires the base CTools module, which is already present once you
have installed it above.
