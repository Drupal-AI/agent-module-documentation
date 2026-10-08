# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only dependency.
- On each format where you want it, **Source Editing** must be enabled — the
  plugin only preserves selection when you can switch to Source mode. It also
  works with the CKEditor CodeMirror Source Editing plugin.

There are no third-party Composer packages to add.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_textselection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_textselection -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_textselection -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, configure
a CKEditor 5 format, enable the **Text Selection** plugin under CKEditor 5 plugin
settings, and confirm **Source Editing** is on. Save, then edit some content:
select a run of text, switch to Source mode and back, and confirm the same
selection is still highlighted and scrolled into view.
