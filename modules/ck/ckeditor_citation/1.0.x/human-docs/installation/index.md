# Installation

## Requirements

- **Drupal 10, 11 or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **CKEditor 5** module, which ships with Drupal.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_citation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_citation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_citation -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, configure
a CKEditor 5 format, and confirm a **Citation** button is available in the
toolbar‑configuration tray. Drag it into the active toolbar and save. Edit content
in that format, select some text, and click the button — the selection should be
wrapped in a `<cite>` tag.
