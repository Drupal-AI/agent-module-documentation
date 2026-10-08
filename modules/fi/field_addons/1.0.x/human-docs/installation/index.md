# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2||^10||^11`).
- No other module dependencies for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/field_addons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_addons -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_addons -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Field Addons Select2** | `field_addons_select2` | A Select2‑based widget that turns a plain select list into a searchable dropdown — helpful on fields with many options. |

Enable it only if you want the Select2 widget:

```bash
drush en field_addons_select2 -y
```

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep
field_addons`. Then, on any field's **Manage display**, you should see the **Plain
Text HTML Formatter** option; if you enabled the submodule, the Select2 widget
should be available on list fields under **Manage form display**. See the
[overview](../index.md#how-to-use-it) for how to apply each.
