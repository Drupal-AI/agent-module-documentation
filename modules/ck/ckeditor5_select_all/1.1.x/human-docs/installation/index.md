# Installation

## Requirements

- **PHP 8.1 or higher.**
- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **CKEditor 5** module — bundled with Drupal core, so no separate
  install is needed.

There are no third-party Composer or PHP library requirements, and no JavaScript
build step.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_select_all -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_select_all -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_select_all -y
```

You can also enable it manually via **Admin › Extend**.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, edit a
CKEditor 5 format, and confirm the **Select All** button appears in the *Available
toolbar items*. Drag it onto the toolbar, save, then edit content and press Ctrl/Cmd
+ A — only the content inside that editor field should be selected, not the rest of
the page.
