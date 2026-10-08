# Installation

## Requirements

CKEditor BiDi Buttons is a small, core‑only CKEditor 5 add‑on:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), enabled — the only dependency, and the
  editor the button plugs into.

There are no third‑party Composer packages or PHP extensions to install; the CKEditor 5
plugin is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_bidi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_bidi -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_bidi -y
```

This also enables **CKEditor 5** if it isn't already on. Or enable **CKEditor BiDi
Buttons** from **Extend** (`/admin/modules`).

There are no submodules and no configuration form.

## Next steps

Enabling the module makes the **Direction** toolbar button available; it does nothing
until you add it to a text format's CKEditor 5 toolbar. See
[How to use it](../index.md#how-to-use-it) on the overview page.
