# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core`) — the shared base module that supplies every EBT
  block's design widget.
- **Block Field** (`block_field`) — lets the block type embed another Drupal
  block.

Composer pulls both dependencies in automatically with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install EBT Core and Block
Field and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_block -y
```

This also enables `ebt_core` and `block_field` if they are not already on.

## Verify it worked

Edit a page with Layout Builder (or go to **Structure → Block layout**), click
**Add block**, and confirm that **EBT Block** appears as an available block type.
Placing one, choosing a block to embed, and saving confirms the module is working.
