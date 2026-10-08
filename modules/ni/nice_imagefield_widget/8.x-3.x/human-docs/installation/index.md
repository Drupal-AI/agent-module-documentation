# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Image** module (part of standard Drupal).
- The contributed **[jQuery UI Sortable](https://www.drupal.org/project/jquery_ui_sortable)**
  module (`jquery_ui_sortable`) — this provides the drag-and-drop library that
  used to ship with core. Composer pulls it in for you when you require the
  widget with the `-W` flag below.
- The **jQuery Flip** plugin library, used for the click-to-edit image tiles.

If you plan to upload many large images at once, you may also need to raise a
few PHP settings in `php.ini`: `max_input_vars`, `max_file_uploads`,
`post_max_size`, and `upload_max_filesize`.

## Install with Composer

From the project root:

```bash
composer require drupal/nice_imagefield_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
jQuery UI Sortable module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nice_imagefield_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nice_imagefield_widget -y
```

Drupal enables the jQuery UI Sortable dependency at the same time.

## Verify it worked

Edit a content type that has a multi-value Image field, open its **Manage form
display**, and confirm that **Nice Multiple** appears in the widget dropdown for
that field. Select it, save, then edit a node — the field should now show a
draggable thumbnail grid instead of the default tabledrag rows.
