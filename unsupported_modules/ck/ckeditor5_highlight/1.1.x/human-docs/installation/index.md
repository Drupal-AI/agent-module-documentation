# Installation

> **Note:** This module is deprecated in favour of **CKEditor 5 Plugin Pack**
> (`ckeditor5_plugin_pack`). For new projects, install that instead. Follow the
> steps below only for an existing site that already uses CKEditor5 highlight.

## Requirements

- **Drupal 10.1** (`core_version_requirement: ^10.1`).
- **PHP 8.1** or newer.
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only module
  dependency.

There are no third‑party Composer library requirements (the upstream CKEditor
highlight plugin is bundled).

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_highlight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_highlight -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_highlight -y
```

Then add the **Highlight** button to your CKEditor 5 text formats (see the "How to
use it" section of the [overview](../index.md)).

## Verify it worked

Add the **Highlight** button to a CKEditor 5 text format and save. Open a content
edit form using that format — selecting text and clicking the Highlight button
should apply a marker or pen, producing `<mark>` markup with a colour class.
