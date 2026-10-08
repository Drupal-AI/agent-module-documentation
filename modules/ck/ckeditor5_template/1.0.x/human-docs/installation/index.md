# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Text Editor** module (`editor`) enabled — this is the only dependency,
  and it comes with CKEditor 5. Drupal enables it automatically when you turn on
  CKEditor 5 Template. You'll also want core's **CKEditor 5** module enabled, since
  the Template button only appears on CKEditor 5 formats.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_template -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_template -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_template -y
```

Or enable **CKEditor 5 Template** on the **Extend** page (`/admin/modules`).

Enabling the module doesn't add the button anywhere yet — you turn it on per text
format. See [How to use it](../index.md#how-to-use-it) for that.

CKEditor 5 Template has no submodules.
