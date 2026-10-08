# Installation

## Requirements

Entityform Block is lightweight and has no third‑party dependencies:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib modules and no PHP or Composer libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/entityform_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entityform_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entityform_block -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region. You should now see **Entity form** blocks in the picker.
Place one, set its visibility carefully (see the note in the
[guide](../index.md#how-to-use-it)), and save — the entity's add/edit form now
renders in that region.
