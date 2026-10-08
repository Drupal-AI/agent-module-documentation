# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement:
  ^8.9||^9||^10||^11`).
- Core's **Block** module (`block`) — part of core, enabled as a dependency.
- The **Fences** module (`fences`) — the base module this one extends. Composer
  pulls it in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/fences_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in the Fences module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fences_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fences_block -y
```

This also enables Fences (and core Block) if they are not already on.

## Verify it worked

Go to **Structure → Block layout** and click **Configure** on any block. You
should now see a **Fences Block** fieldset in the block's configuration form,
where you can set the wrapper element and classes. If it is missing, confirm the
Fences module enabled successfully with `drush pm:list --status=enabled | grep
fences`.
