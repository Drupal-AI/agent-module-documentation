# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The core **CKEditor** module (`ckeditor`) — this is **CKEditor 4**, the legacy
  editor. My CKE Button depends on it and does **not** work with CKEditor 5, so
  your site must still have the CKEditor 4 module available and at least one text
  format that uses it.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/myckebutton -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/myckebutton -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en myckebutton -y
```

Drupal enables the CKEditor 4 dependency automatically if it is not already on.

## Verify it worked

1. Visit **`/admin/config/content/myckebutton-styles`** — you should reach the
   styles form where you can add a new named style.
2. Edit a CKEditor 4 text format at **Configuration → Content authoring → Text
   formats and editors** and confirm the **My CKE Button** appears in the list of
   available toolbar buttons you can drag into the toolbar.

From here, see [How to use it](../index.md#how-to-use-it) to define styles and
add the button to a format.
