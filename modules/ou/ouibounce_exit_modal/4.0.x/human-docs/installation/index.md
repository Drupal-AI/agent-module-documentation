# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Block** (`block`) and **Views** (`views`) modules — enabled
  automatically as dependencies.
- The **Ouibounce JavaScript library** (tested with v0.0.12). In 4.x the module
  loads it from `/libraries/ouibounce/build/ouibounce.min.js`.

## Install the module with Composer

From the project root:

```bash
composer require drupal/ouibounce_exit_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ouibounce_exit_modal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install the Ouibounce library

The module needs the third‑party Ouibounce library in `/libraries`. The easiest
way (requires the asset‑packagist repository configured in your project) is via
Composer:

```bash
composer require bower-asset/ouibounce
# or
composer require npm-asset/ouibounce
```

Alternatively, download the library manually and place its folder in `/libraries`
so the built file is available at
`/libraries/ouibounce/build/ouibounce.min.js`.

## Enable the module

```bash
drush en ouibounce_exit_modal -y
```

## Verify it worked

Check **Reports → Status report** to confirm the Ouibounce library is detected.
Then place the **Ouibounce Block** in **Structure → Block layout**, configure its
content, and test the exit‑intent behavior by moving your cursor to leave the page.
