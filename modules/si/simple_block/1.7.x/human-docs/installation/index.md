# Installation

## Requirements

Simple Block is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** (`block`) and **Filter** (`filter`) modules — both are standard
  core modules, and Drupal enables them automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_block -y
```

Once enabled, the block manager is available at **Structure → Block layout → Simple
blocks** (`/admin/structure/block/simple-block`). There is no required configuration —
create your first block and place it.

## Submodule — Layout Builder integration

Simple Block ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Simple Block + Layout Builder** | `simple_block_layout_builder` | Lets you create and edit simple blocks directly from the Layout Builder UI, so you can build these config‑backed blocks while laying out a page. |

Enable it only if you use Layout Builder:

```bash
drush en simple_block_layout_builder -y
```

## Verify it worked

Log in as an administrator and visit **Structure → Block layout → Simple blocks**.
Click **Add simple block**, save a test block, then place it from the **Block layout**
page. Running `drush config:status` should list your new
`simple_block.simple_block.<id>` object as exportable configuration.
