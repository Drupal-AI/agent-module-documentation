# Installation

## Requirements

SVG Icon Field is lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which is part of the standard install and
  is enabled automatically as a dependency.

There are no third‑party Composer packages or PHP library requirements. Note that
the released branch is an alpha (`8.x-1.0-alpha11`), so test it before relying on
it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/svg_icon_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_icon_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_icon_field -y
```

## Verify it worked

Go to any bundle's **Manage fields** screen (for example
**Structure → Content types → Article → Manage fields**), click **Add field**,
and confirm that **SVG Icon** appears as a choice in the field type list (under
*Reference*). If it does, the module is installed correctly. See
[Configuration](../configuration/index.md) to finish setting up a field.
