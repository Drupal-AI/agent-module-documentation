# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`), which ships with Drupal and provides the accounts
  the block reads birthdays from.
- A user birthday field on your accounts for the block to read.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/birthday_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/birthday_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en birthday_block -y
```

After enabling, place the birthday block through **Structure → Block layout**
(`/admin/structure/block`) and restrict its visibility to the appropriate audience.
