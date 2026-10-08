# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** (`block`) module — part of a standard Drupal install and
  enabled automatically as a dependency.

There are no third‑party Composer library or PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dmb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dmb -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dmb -y
```

## Place the block

Go to **Structure → Block layout** (`/admin/structure/block`), click **Place
block** in your chosen region, and add the **Dark Mode Button** block.

## Verify it worked

Reload the front end of your site. The dark‑mode icon button should appear in the
region where you placed the block. Click it — the site should switch between light
and dark appearance, and the choice should persist as you navigate.
