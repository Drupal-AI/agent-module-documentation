# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- Core's **CKEditor 5** (`ckeditor5`) and **Text Editor** (`editor`) modules —
  these are the dependencies, and Drupal enables them automatically when you turn
  on Link Styles.
- The text format you use it on must have the core **Link** button on its toolbar;
  the styles UI only appears when that button is present.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_link_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_link_styles -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_link_styles -y
```

Or enable **CKEditor 5 Link Styles** on the **Extend** page (`/admin/modules`).

Enabling the module doesn't change any format on its own — you add styles per text
format. See [How to use it](../index.md#how-to-use-it) for that.

CKEditor 5 Link Styles has no submodules.
