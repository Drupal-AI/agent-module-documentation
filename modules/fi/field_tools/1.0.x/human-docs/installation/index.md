# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Field UI** module (`field_ui`) enabled — Drupal enables it automatically
  as a dependency when you turn on Field Tools.
- *(Optional)* the **GraphAPI** module — only needed for the field-reference graph
  report. Everything else works without it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_tools -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_tools -y
```

There are no submodules. Once enabled, the clone/export tabs appear on every
bundle's *Manage fields* page and the reports appear under **Reports → Fields** —
see [Configuration](../configuration/index.md).

## Grant the permission

The site-wide field reports are gated by a permission — grant it at **People →
Permissions**:

- **Access field tools pages** — lets a user view the reports under
  `/admin/reports/fields`.

The per-bundle clone/copy/export actions instead use the core "administer *(entity
type)* fields" permission (e.g. **Administer content fields**), which administrators
already have.
