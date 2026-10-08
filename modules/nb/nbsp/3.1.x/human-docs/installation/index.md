# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- Core's **CKEditor 5** (`ckeditor5`) and **Editor** (`editor`) modules — Drupal
  enables these automatically as dependencies when you turn on NBSP.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/nbsp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nbsp -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nbsp -y
```

There is no settings page to visit after enabling. To start using it, add the
toolbar button and enable the filter on a text format — see
[How to use it](../index.md#how-to-use-it) on the overview page.
