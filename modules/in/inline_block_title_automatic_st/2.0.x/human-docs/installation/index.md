# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- Both of these modules, which are hard dependencies:
  - **Inline Block Title Automatic** (`inline_block_title_automatic`)
  - **Layout Builder Symmetric Translation** (`layout_builder_st`)
- Core's **Layout Builder** and multilingual/translation modules, as required by
  those two dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_block_title_automatic_st -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the two required modules) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_block_title_automatic_st -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_block_title_automatic_st -y
```

Enabling it will also enable its two dependencies if they are not already on.
There is nothing further to configure — the bridge is active immediately.

## Verify it worked

Set up a multilingual site with Layout Builder and an inline block, then use
Layout Builder Symmetric Translation to **translate** that inline block. On the
translate form the block-title field should no longer be shown, and saving the
translation should not raise a duplicate-block-title validation error. If the
title field still appears, confirm that both dependency modules are enabled
alongside this one.
