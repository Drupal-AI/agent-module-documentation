# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- Core's **CKEditor** module (`ckeditor`) — the **legacy CKEditor 4** editor.
  This plugin targets CKEditor 4, not CKEditor 5, so it only matters on sites
  still using CKEditor 4 text formats.

There are no third-party Composer packages or PHP library requirements.

> **Note:** This project is marked **obsolete / minimally maintained**, in step
> with CKEditor 4's end of life. Use it only if you still have CKEditor 4 formats
> in play (typically mid-migration).

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_bettercollapse -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor_bettercollapse -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_bettercollapse -y
```

## Verify it worked

On a text format that uses the legacy CKEditor 4 editor with a two-row toolbar,
open the CKEditor settings and confirm the **CKEditor Better Collapse enabled**
checkbox is present. Tick it, save, then edit content with that format — the
toolbar should start with only its first row visible and expand on demand. See
the [main guide](../index.md#how-to-use-it) for the steps.
