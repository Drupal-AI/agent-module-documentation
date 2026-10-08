# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **CKEditor 5** module, enabled with at least one text format
  using it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_horizontal_line -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_horizontal_line -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_horizontal_line -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, edit a
CKEditor 5 format, and confirm the **Horizontal line** button appears in the
*Available toolbar items*. Drag it onto the toolbar, save, then edit some
content and click the button — a horizontal rule should appear in the editor.
