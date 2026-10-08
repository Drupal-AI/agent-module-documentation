# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`drupal/ebt_core` `^2.0`) — the shared base module that supplies
  every EBT block's design widget.
- **Paragraphs** (`drupal/paragraphs` `^1.0`).

Composer pulls both dependencies in automatically with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_accordion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install EBT Core and
Paragraphs and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_accordion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_accordion -y
```

This also enables `ebt_core` and `paragraphs` if they are not already on.

## Verify it worked

Edit a page with Layout Builder (or go to **Structure → Block layout**), click
**Add block**, and confirm that **Accordion** appears as an available block type.
Placing one and saving confirms the module is working.
