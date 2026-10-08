# Installation

## Requirements

Layout Builder Usage Reports needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`), which Drupal enables
  automatically as a dependency. The report only makes sense once you have nodes
  using Layout Builder overrides.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_usage_reports -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_usage_reports -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_usage_reports -y
```

## Grant the permission

The module defines one restricted permission, **Access node layout reports**,
required to view the report. Grant it only to trusted administrator or auditor
roles. Once granted, the report is available at **Reports → Layout Builder Usage
Report** — see [Configuration](../configuration/index.md).
