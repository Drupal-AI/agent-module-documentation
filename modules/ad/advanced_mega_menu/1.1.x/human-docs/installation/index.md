# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Views** and **Block** (part of the standard install) — the mega-menu
  content is built from Views and Blocks.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_mega_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_mega_menu -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_mega_menu -y
```

After enabling, grant the module's permission on **People → Permissions** to the
roles that should build mega menus, then design the grid and add content — see
[Configuration](../configuration/index.md).
