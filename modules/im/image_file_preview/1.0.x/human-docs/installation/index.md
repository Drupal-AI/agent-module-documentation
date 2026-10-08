# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 ||
  ^11`).
- Drupal core only — there are **no** module dependencies and no third‑party
  Composer or PHP libraries. You'll want the core **Views** module enabled (it is
  on by default in a standard install) so you have somewhere to add the field.

## Install with Composer

From the project root:

```bash
composer require drupal/image_file_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_file_preview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_file_preview -y
```

There is no configuration step.

## Verify it worked

Go to **Structure → Views**, edit or create a View based on **Files**, and add a
field. Searching the field list for **Image File Preview** should return the new
field. Add it, save, and the View preview should show image thumbnails for image
files.
