# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The contributed **[Token](https://www.drupal.org/project/token)** module
  (`token`) — required, and pulled in automatically by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/page_metatag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and bring in the Token module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_metatag -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_metatag -y
```

This enables Page Metatag and, if it is not already on, the Token module it depends
on.

## Verify it worked

Confirm both modules are enabled on **Extend** (`/admin/modules`), then continue to
[Configuration](../configuration/index.md) to set your meta tags. Once configured,
view the source of a front‑end page and confirm the meta tags appear in the
`<head>`.
