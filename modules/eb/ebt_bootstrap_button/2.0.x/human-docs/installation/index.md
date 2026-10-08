# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core`) — the shared base module that supplies every EBT
  block's design widget. This is the only dependency.
- A Bootstrap-based theme is what makes the Bootstrap classes render as intended,
  though it is not a hard requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_bootstrap_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install EBT Core and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_bootstrap_button -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_bootstrap_button -y
```

This also enables `ebt_core` if it is not already on.

## Verify it worked

Edit a page with Layout Builder (or go to **Structure → Block layout**), click
**Add block**, and confirm that **Bootstrap Button** appears as an available block
type. Placing one and saving confirms the module is working.
