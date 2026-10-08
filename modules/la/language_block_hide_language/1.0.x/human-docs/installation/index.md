# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- Core's **Language** module (`language`), enabled automatically as a dependency.
- The core **language‑switcher block** placed in a region for the hide setting to
  have anything to act on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/language_block_hide_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_block_hide_language -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_block_hide_language -y
```

## Verify it worked

Go to **Structure → Block layout**, edit your **Language switcher** block, and look
for the new option to hide one or more languages in the block's settings. Ticking a
language and saving should remove it from the switcher on the front end — see "How
to use it" in the [overview](../index.md).
