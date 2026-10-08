# Installation

## Requirements

Responsive Image Field needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **PHP 8.1 or newer** (`php_requirement: 8.1`).
- These core modules, all enabled automatically as dependencies:
  - **Responsive Image** (`responsive_image`) — the breakpoint/style system this
    field builds on.
  - **Media Library** (`media_library`) — the image picker.
  - **Media Library form element** (`media_library_form_element`).

There are no third‑party Composer packages beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_image_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in and update the
core dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_image_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_image_field -y
```

## Verify it worked

1. Go to **Configuration → Media → Responsive image styles** and confirm you have
   at least one responsive image style (create one if not).
2. Go to a content type's **Manage fields → Add field**. The field‑type list
   should now offer a **Responsive image** field type.
3. Add the field, set its display, and edit a piece of content — you should be
   able to choose a different image per breakpoint through the Media Library.
