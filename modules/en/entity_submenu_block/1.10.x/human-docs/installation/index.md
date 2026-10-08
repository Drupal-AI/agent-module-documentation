# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) — a hard dependency; Drupal enables it
  automatically.
- No contrib dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_submenu_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_submenu_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_submenu_block -y
```

## Permissions

The module adds no permission of its own — placing and configuring the block uses
core's **"administer blocks"** permission, which administrators already have.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block**. In the block list you should see one entry per menu, each labelled
*"(Menu name) (Entity Submenu Block)"*. Placing one is covered in
[Configuration](../configuration/index.md).
