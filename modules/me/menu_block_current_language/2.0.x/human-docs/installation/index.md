# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 8.0 or newer** (`php: >=8.0`).
- Core's **Block** module (`block`) and **Locale** module (`locale`) — both are
  hard dependencies. Locale is what provides the string-translation lookups the
  module uses.
- A multilingual site (more than one language configured) is what makes the module
  useful, though it installs fine on any site.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_block_current_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_block_current_language -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_block_current_language -y
```

This also enables Block and Locale if they aren't on already.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block**. You should see one block per menu under the category **"Menu block
current language"**. Placing one is covered in
[Configuration](../configuration/index.md).
