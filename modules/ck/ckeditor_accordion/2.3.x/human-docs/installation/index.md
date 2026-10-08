# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only dependency. Drupal
  enables it automatically if it isn't already on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_accordion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/ckeditor_accordion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_accordion -y
```

Enabling the module makes the **Accordion** button *available* — it doesn't add it to
any toolbar automatically. Finish the setup by adding the button to a text format's
CKEditor 5 toolbar and allowing the accordion tags, as described in the
[overview](../index.md#how-to-use-it).
