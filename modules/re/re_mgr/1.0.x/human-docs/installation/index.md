# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- The contrib **Entity** module (`entity`), which provides the shared entity
  infrastructure the module builds on.
- For the **visualization** submodule only: the **Webform** module and core
  **Media**.
- Core's **Views** module is recommended — when it is enabled the module provides
  ready-made views with sorting, filtering, and bulk publish/delete operations for
  its entities.

## Install with Composer

From the project root:

```bash
composer require drupal/re_mgr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies and bring in the contrib Entity module if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/re_mgr -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en re_mgr -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Presentation** | `re_mgr_presentation` | A configurable block for presenting portfolio data via pluggable, tabbed presentation plugins. |
| **Visualization** | `re_mgr_visualization` | A richer visual presentation plugin and a coordinate field on entity types other than Estate. Requires the presentation submodule, **Webform**, and core **Media**. |
| **Demo** | `re_mgr_demo` | Installs demo content for evaluation. |

For example, to add the presentation block:

```bash
drush en re_mgr_presentation -y
```

## Verify it worked

Visit **`/admin/re-mgr`** as a user with the **Access real estate manager
administration pages** permission and confirm the admin section loads. Create an
**Estate** to check the entity types are in place, then continue building
Buildings, Floors, and Flats as described on the [overview page](../index.md).
