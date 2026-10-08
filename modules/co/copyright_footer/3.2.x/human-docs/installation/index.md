# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- Core's **Block** module (`block`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on Copyright Footer.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/copyright_footer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/copyright_footer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en copyright_footer -y
```

There are **no submodules**. Enabling the module makes the **Copyright Footer**
block available to place — head to [Configuration](../configuration/index.md) to
put it in your footer and set the text.
