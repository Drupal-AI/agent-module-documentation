# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Views** module (`views`), enabled by default.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/galleriajs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/galleriajs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en galleriajs -y
```

## Verify it worked

Go to **Structure → Views**, edit any View, and open its **Format** settings. The
**Galleria** style should appear as an available format. Select it on a View that
outputs images, save, and confirm the results render as a Galleria gallery on the
front end.
