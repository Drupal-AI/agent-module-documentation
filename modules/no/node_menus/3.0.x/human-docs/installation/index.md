# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Content Translation** module (`content_translation`), enabled
  automatically as a dependency. No other contributed modules are needed and there
  are no third‑party libraries.

Because the module's purpose is language‑aware menu selection, you will also want
core's **Language** and **Menu UI** in use and at least one extra language added.

## Install with Composer

From the project root:

```bash
composer require drupal/node_menus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_menus -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_menus -y
```

Drupal enables the required Content Translation dependency at the same time.

## Verify it worked

Add a language, create a couple of menus, then edit a content type, enable
translation for it, tick **Enable language menus**, and choose menus per language.
Editing a node of that type should now show a menu dropdown limited to the menus for
the node's language. See "How to use it" on the [overview page](../index.md).
