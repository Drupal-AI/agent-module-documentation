# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field UI** module (`field_ui`) enabled — this is a required dependency,
  and Drupal enables it automatically when you turn on Entity UI Builder.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_ui -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_ui -y
```

## Verify it worked

After enabling, confirm the module appears in **Extend** (`/admin/modules`) and
that its permissions show up on **People → Permissions**
(`/admin/people/permissions`). Then create an Entity UI tab config entity and check
that the new tab appears on an entity of the target type — see *How to use it* on
the [overview page](../index.md).
