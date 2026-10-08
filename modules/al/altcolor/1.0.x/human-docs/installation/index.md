# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies, and no third-party Composer or PHP library requirements.
- A colour-aware theme to apply the customisation to.

## Install with Composer

From the project root:

```bash
composer require drupal/altcolor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/altcolor -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en altcolor -y
```

Once enabled, you can customise a theme's colours from the admin UI — see
[How to use it](../index.md#how-to-use-it).
