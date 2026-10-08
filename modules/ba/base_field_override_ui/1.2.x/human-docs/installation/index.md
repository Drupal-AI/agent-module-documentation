# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field UI** module (`field_ui`) — the only dependency, enabled
  automatically as a dependency. (Field UI is what provides the *Manage fields*
  pages this module extends.)

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/base_field_override_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/base_field_override_ui -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en base_field_override_ui -y
```

There is **no configuration form and no submodules**, and the module adds no
permission of its own — it reuses core's per‑entity **Administer … fields**
permission. Once enabled, the **Base fields Override** tab appears on each entity
type's *Manage fields* page — see
[How to use it](../index.md#how-to-use-it).

## Verify it worked

Go to a content type's **Manage fields** page (e.g.
`/admin/structure/types/manage/article/fields`) and confirm a **Base fields
Override** secondary tab appears next to the **Fields** tab.
