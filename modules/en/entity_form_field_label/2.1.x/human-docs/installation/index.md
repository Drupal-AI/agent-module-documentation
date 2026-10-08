# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Field** module (`field`) — the only dependency, and it is part of the
  standard install, enabled automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_form_field_label -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_form_field_label -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_form_field_label -y
```

Or enable **Entity Form Field Label** from **Extend** (`/admin/modules`).

There are no submodules and no configuration page. Once enabled, a **Rewrite
label** option appears in each field's widget settings (Manage form display) and
formatter settings (Manage display) — see
[How to use it](../index.md#how-to-use-it) on the overview page.
