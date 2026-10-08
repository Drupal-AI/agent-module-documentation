# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- CKEditor from Drupal core (the module adds a button to the editor).
- No modules outside Drupal core, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_section -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_section -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_section -y
```

## Add the button and allow the markup

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit the text format you want.
2. In the CKEditor toolbar configuration, add the **Section** button to the
   toolbar.
3. Make sure the format's **allowed HTML tags** include `<section>`, otherwise the
   filter will strip it on output.
4. Save the text format.

## Verify it worked

Edit a content field using that format, select some content, click the **Section**
button, save, and confirm the rendered page contains a `<section>` wrapper around
that content.
