# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only dependency, and Drupal
  enables it automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_fullscreen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_fullscreen -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_fullscreen -y
```

There is nothing to configure globally. To actually give editors the button, add it to a
text format's CKEditor 5 toolbar — see the
[overview guide](../index.md#how-to-use-it).

## Verify it worked

Configure a CKEditor 5 text format at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`): the **Fullscreen** button should now appear in
the *Available buttons* tray of the toolbar builder. Add it, save, then edit a piece of
content using that format and click the button — the editor should expand to fill the
browser window.
