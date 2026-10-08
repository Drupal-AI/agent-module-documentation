# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core`) — the shared base module that supplies every EBT
  block's design widget.
- **Paragraphs** (`paragraphs`).
- Core **Datetime** (`datetime`) — for setting the countdown's target date/time.

Composer pulls these dependencies in automatically with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_countdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install EBT Core,
Paragraphs, and Datetime and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_countdown -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_countdown -y
```

This also enables `ebt_core`, `paragraphs`, and core `datetime` if they are not
already on.

## Verify it worked

Edit a page with Layout Builder (or go to **Structure → Block layout**), click
**Add block**, and confirm that **Countdown** appears as an available block type.
Placing one, setting a target date, and saving confirms the module is working.
