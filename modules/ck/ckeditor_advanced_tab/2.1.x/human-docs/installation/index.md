# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- Core's **CKEditor** module (`ckeditor`) — the **legacy CKEditor 4** editor.
  This is deprecated and removed in favour of CKEditor 5 in newer Drupal, so this
  module only makes sense on sites still using CKEditor 4 text formats.

There are no third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_advanced_tab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor_advanced_tab -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_advanced_tab -y
```

## Verify it worked

On a text format that uses the legacy CKEditor 4 editor, edit some content and
open a link, image, or table dialog. An **Advanced** tab should now appear,
offering id, class, style, and text-direction fields. If your site has already
moved fully to CKEditor 5, this module has no effect — it applies only to
CKEditor 4 formats.
