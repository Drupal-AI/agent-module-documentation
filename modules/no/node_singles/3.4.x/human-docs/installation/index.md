# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 7.1** or newer.
- Core's **Node** module (`node`), enabled on any standard Drupal site.

No contributed‑module dependencies and no third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/node_singles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_singles -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_singles -y
```

## Verify it worked

Go to **Structure → Content types**, add or edit a content type, and confirm a new
**Singles** tab with the **This is a content type with a single entity** checkbox
appears. Tick it and save — the module should create exactly one node for the type
and prevent you from adding another. The **Content → Singles**
(`/admin/content/singles`) overview should then list it. See "How to use it" on the
[overview page](../index.md).
