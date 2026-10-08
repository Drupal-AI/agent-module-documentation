# Installation

## Requirements

CKEditor iFrame is lightweight. It needs:

- **Drupal 10.5 or 11.2+** (`core_version_requirement: ^10.5 || ^11.2`).
- Core's **CKEditor 5** editor (part of Drupal core) — this is a CKEditor 5
  plugin, so the text formats you add the button to must use the CKEditor 5
  editor.

There are no third‑party Composer packages, PHP libraries, or other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_iframe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_iframe -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_iframe -y
```

Enabling the module does not, on its own, change any editor. Nothing appears in
your content until you add the **Iframe Embed** button to a text format — see
[How to use it](../index.md#how-to-use-it) on the overview page.

There are no submodules.
