# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies (you'll use core's Field UI to add the field).
- No external Composer or JavaScript library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/eaf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eaf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eaf -y
```

## Verify it worked

There's no admin settings page to check. Instead, go to a bundle's **Manage fields**
screen (for example *Structure → Content types → Article → Manage fields*), click
**Add field**, and confirm that **Entity Attributes Field** now appears in the list
of available field types. From there, follow the "How to use it" steps in the
[overview](../index.md).
