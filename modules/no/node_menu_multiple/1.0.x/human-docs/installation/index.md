# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core modules, all enabled automatically as dependencies: **Content Translation**
  (`content_translation`), **Menu UI** (`menu_ui`), **Node** (`node`), and
  **Language** (`language`).

No contributed‑module dependencies and no third‑party libraries are required. This
module is designed for multilingual sites, so it expects Content Translation and
Language to be in use.

> **Note:** This project does not carry Drupal's security‑advisory coverage. Weigh
> that against your site's risk tolerance before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/node_menu_multiple -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_menu_multiple -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_menu_multiple -y
```

Drupal enables the required core modules (Content Translation, Menu UI, Node,
Language) at the same time.

## Verify it worked

Add multiple languages, create at least two menus, then edit a content type and
enable the module's per‑type menu option (choosing available menus per language).
Editing a node of that type should now show the **"Menu Form Nodes"** section with
add/delete buttons for multiple menu links. See "How to use it" on the
[overview page](../index.md) for the full workflow.
