# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core`) — the shared base module that supplies every EBT
  block's design widget.
- **Paragraphs** (`paragraphs`).

Composer pulls both dependencies in automatically with the command below. (The
countUp.js library the block uses is provided by the module.)

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_counter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install EBT Core and
Paragraphs and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_counter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_counter -y
```

This also enables `ebt_core` and `paragraphs` if they are not already on.

## Verify it worked

Edit a page with Layout Builder (or go to **Structure → Block layout**), click
**Add block**, and confirm that **Counter** appears as an available block type.
Placing one, adding a number, and saving confirms the module is working.
