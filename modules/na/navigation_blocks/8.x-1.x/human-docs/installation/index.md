# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** (`block`) and **Link** (`link`) modules — enabled automatically
  as dependencies.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/navigation_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/navigation_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en navigation_blocks -y
```

## Verify it worked

Go to **Structure → Block layout**, click **Place block**, and confirm the
module's navigation blocks (such as the generic back button) appear in the list.
Place one, configure its target, and test it on the front end.

For placement and configuration details, see
[How to use it](../index.md#how-to-use-it).
