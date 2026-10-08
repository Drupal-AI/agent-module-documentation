# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules —
  Drupal enables these automatically as dependencies when you turn on Entity
  Reference Media.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_media -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_media -y
```

Drupal will enable **Media** and **Media Library** at the same time if they are
not already on.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and add a new
field. You should be able to choose the Entity Reference Media field type. After
adding it, check that its optimized Media Library widget appears on *Manage form
display* and its Entity Reference formatter on *Manage display*.
