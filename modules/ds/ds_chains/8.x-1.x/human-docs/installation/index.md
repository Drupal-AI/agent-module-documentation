# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Display Suite** module (`ds`) — this is the module Chains extends. Enable
  it if it is not already on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ds_chains -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you do not already have Display Suite installed, add
it too: `composer require drupal/ds -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ds_chains -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ds_chains -y
```

If Display Suite is not yet enabled, turn it on first (or in the same command):

```bash
drush en ds ds_chains -y
```

## Verify it worked

Pick a content type that has an **entity reference** field and open its
**Manage display** (**Structure → Content types → *(type)* → Manage display**).
Using the Display Suite layout, confirm that fields from the referenced entity
are now available to place alongside the host entity's own fields. See the
["How to use it"](../index.md#how-to-use-it) section for the full workflow.
