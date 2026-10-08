# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The contrib **CKEditor** module (the CKEditor 4 editor) and core's **System**
  module. This module integrates the CKEditor **4** editor, not core's CKEditor 5.

There are no additional third-party Composer packages, and the required CKEditor
plugin JavaScript is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_textindent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_textindent -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_textindent -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, edit a
format that uses the CKEditor 4 editor, and confirm a **Text Indent** button is
available to drag into the toolbar. Drag it in, save, then edit some content and
click the button on a paragraph to confirm the indent toggles on and off.
