# Installation

## Requirements

Hero Block relies only on core modules:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** (`node`) and **Block** (`block`) modules — both are dependencies
  and Drupal enables them automatically if they are not already on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hero_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hero_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hero_block -y
```

## Verify it worked

Go to **Structure → Block layout**, click **Place block**, and confirm that a
**Hero Block** option is available. Place one, give it an image, title, and
subtitle, save, and view the page where you placed it — the hero banner should
render.
