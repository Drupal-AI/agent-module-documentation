# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on this module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_responsive_plugin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_responsive_plugin -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_responsive_plugin -y
```

This also enables core CKEditor 5 if it isn't already on. On install the module
shows a status message linking to the text‑formats page — that's where you turn
the button on. There is no module‑level configuration; the Responsive Area button
is enabled per text format (see
[How to use it](../index.md#how-to-use-it)).

## Submodules

CKeditor Responsive Plugin ships no submodules.
