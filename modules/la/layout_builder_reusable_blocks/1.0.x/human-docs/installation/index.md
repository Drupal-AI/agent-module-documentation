# Installation

## Requirements

Layout Builder Reusable Blocks extends core Layout Builder. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled.
- Core's **Block content** module (`block_content`) enabled — this provides the
  reusable custom blocks the module works with.

Drupal will enable both dependencies (and their own dependencies) automatically
when you turn on this module. There are no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_reusable_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_reusable_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_reusable_blocks -y
```

## Verify it worked

Edit a page that uses Layout Builder. You should now be able to create a reusable
content block, and edit an existing reusable block in place, without leaving the
Layout Builder screen for the block library at `/admin/content/block`. See
[Configuration](../configuration/index.md) for the settings form and the restricted
permission that governs it.
