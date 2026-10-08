# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_historylog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_historylog -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_historylog -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, configure
a CKEditor 5 format, and confirm a **History Log** button is available in the
toolbar‑configuration tray. Drag it into the active toolbar and save. Edit content
in that format, type for a while, then click the History Log button — you should
see autosaved revisions you can restore.
