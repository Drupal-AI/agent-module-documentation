# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** module (part of the standard install) — the module adds its
  fields to node entities.
- No other contributed modules and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_body_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/custom_body_class -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_body_class -y
```

There are **no submodules** and no configuration step. Once enabled, the body
class field appears on every node's add/edit form, and the *Custom Body Class
Settings* group appears on each content type's edit form — see
[How to use it](../index.md#how-to-use-it).
