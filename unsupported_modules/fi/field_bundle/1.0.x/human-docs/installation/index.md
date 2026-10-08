# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`). Note it does
  **not** support Drupal 11.
- Core's **User** module (`user`) — part of core, enabled as a dependency.

> **Note:** development of this module is discontinued; the maintainers suggest
> [Storage Entities](https://www.drupal.org/project/storage) for new work. See the
> [overview](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/field_bundle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_bundle -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_bundle -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Field Bundle Canonical** | `field_bundle_canonical` | Gives Field Bundle entities a canonical page / URL of their own. |
| **Group Field Bundle** | `group_field_bundle` | Integrates Field Bundle entities with the [Group](https://www.drupal.org/project/group) module as group content. |

Enable whichever you need:

```bash
drush en field_bundle_canonical -y
drush en group_field_bundle -y
```

## Verify it worked

Go to **`/admin/structure/field-bundle`** — you should see the bundle‑type
management overview. From there you can create your first bundle, as described in
[Configuration](../configuration/index.md).
