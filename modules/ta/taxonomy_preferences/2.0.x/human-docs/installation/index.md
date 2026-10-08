# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Locale** (`locale`) and **Config Translation** (`config_translation`)
  modules — Drupal enables these automatically as dependencies. They let you
  translate the offered term labels and the instruction message per language.

There are no third-party PHP library requirements. To turn the stored session
preferences into a filtered View, you will also want the **Views Extender / Views
Extra** module, which provides a session-variable contextual filter — it is
recommended rather than strictly required.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_preferences -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_preferences -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_preferences -y
```

Enabling the module makes the settings form and the block available, but you still
need to choose the offered terms and place the block. Continue with
[Configuration](../configuration/index.md).
