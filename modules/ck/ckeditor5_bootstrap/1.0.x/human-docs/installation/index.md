# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11||^12`).
- Core's **CKEditor 5** module (`ckeditor5`) and core's **Editor** module
  (`editor`) enabled — these are the dependencies, and Drupal enables them
  automatically as needed.
- For correct front-end rendering, a theme that loads **Bootstrap 5** CSS and
  JavaScript. The module writes Bootstrap markup but does not ship the Bootstrap
  library itself.

There are no third‑party Composer or PHP library requirements for the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_bootstrap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_bootstrap -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_bootstrap -y
```

## Verify it worked

Edit a CKEditor 5 text format at **Configuration → Content authoring → Text
formats and editors**, add the **Bootstrap Div**, **Bootstrap Table**, and
**Bootstrap Components** buttons to the toolbar, and save. Open a content edit form
using that format — the new buttons should appear, and clicking **Bootstrap Div**
opens its popup dialog. Confirm your theme loads Bootstrap 5 so the inserted
components render as intended on the published page.
