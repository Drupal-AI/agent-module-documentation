# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- **PHP 8.0 or newer**.
- Core's **Field** (`field`) and **Taxonomy** (`taxonomy`) modules — Drupal
  enables them automatically as dependencies.

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cshs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cshs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cshs -y
```

Enabling the module makes the widget, formatters, and Views filters available.
Nothing changes until you assign the CSHS widget to a taxonomy field on a form
display — see [How to use it](../index.md#how-to-use-it).

## Submodule — CSHS Menu Link

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **CSHS Menu Link** | `cshs_menu_link` | Uses the same client-side hierarchical selector for the **parent menu item** picker on node and taxonomy term forms, so choosing a parent in a deep menu is just as tidy. |

Enable it only if you want that:

```bash
drush en cshs_menu_link -y
```
