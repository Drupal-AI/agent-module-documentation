# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only dependency,
  and Drupal enables it automatically. You'll also want at least one text format that
  uses CKEditor 5 with the core **Link** toolbar button.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_open_new_tab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_open_new_tab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_open_new_tab -y
```

That's all it takes — there is no configuration form and no submodules. Once
enabled, the **"Open in new window"** checkbox appears in the CKEditor 5 link dialog
on any text format that uses the core Link button.

If you use a text format that limits allowed HTML tags, remember to allow the anchor
to carry a `target` attribute (e.g. `<a href hreflang target>`) so the new‑tab
setting survives filtering — see the [main guide](../index.md#how-to-use-it).
