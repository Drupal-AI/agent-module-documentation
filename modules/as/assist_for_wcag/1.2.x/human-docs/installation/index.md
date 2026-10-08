# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.
- An **account with the accessibility‑widget provider**, so you have a token to
  authenticate the script. Because the widget loads from the provider, visitors'
  browsers will make requests to that third party.

## Install with Composer

From the project root:

```bash
composer require drupal/assist_for_wcag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/assist_for_wcag -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en assist_for_wcag -y
```

After enabling, enter your provider token and turn the widget on — see
[Configuration](../configuration/index.md).

This module has no submodules.
