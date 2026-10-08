# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies — it uses core's menu and block systems.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/contextual_menu_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contextual_menu_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contextual_menu_block -y
```

## Verify it worked

Go to **Structure → Block layout** and click **Place block** in any region. The
list of available blocks should now include **Contextual menu block**. Place it,
choose a menu, and browse to a page inside a menu section — the block should show
that section's navigation.
