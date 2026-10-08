# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- A text format that uses the **CKEditor 5** editor (part of Drupal core on 10 and
  11). The module ships a legacy CKEditor 4 plugin too, but it is unused on modern
  Drupal, which only has CKEditor 5.

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_quote -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_quote -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_quote -y
```

Enabling the module does not change any editor by itself — the Quote button only
appears where you add it. See the *How to use it* section on the
[overview page](../index.md) to add it to a text format's toolbar.
