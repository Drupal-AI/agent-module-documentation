# Installation

## Requirements

- **Drupal 10.5 or 11.2** and newer (`core_version_requirement: ^10.5 || ^11.2`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled. Drupal enables it
  automatically as a dependency.

There are no third-party Composer or PHP library requirements — the module bundles
the CKEditor build it needs.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_html_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_html_embed -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_html_embed -y
```

No submodules ship with this project.

## Next step

Enabling the module doesn't change any text format on its own — it just makes the
**HTML embed** button available. You still need to add that button to a CKEditor 5
toolbar before editors can use it. See the "How to use it" section on the
[overview page](../index.md) for the step-by-step.

## Verify it worked

Configure a CKEditor 5 text format and confirm that **HTML embed** now appears in
the list of *Available buttons* in the toolbar configurator. Once you drag it into
the active toolbar and save, editing content with that format shows the HTML embed
button in the editor.
