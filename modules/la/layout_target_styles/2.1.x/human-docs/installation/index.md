# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`), enabled and in use.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_target_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_target_styles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_target_styles -y
```

## Verify it worked

Open the Layout Builder editor on an entity, add or configure a block (or configure
a section), and confirm a **Block layout target styles** group appears with **Block
HTML ID** and **Block HTML Classes** fields. There is no configuration to do — the
fields are present as soon as the module is enabled. See "How to use it" in the
[overview](../index.md).
