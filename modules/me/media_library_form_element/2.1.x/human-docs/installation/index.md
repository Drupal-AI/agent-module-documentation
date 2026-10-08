# Installation

## Requirements

Media Library Form Element is lightweight. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media Library** (`media_library`) module enabled — this is the only
  dependency, and Drupal enables it automatically when you turn this module on.
  (Media Library in turn pulls in core's **Media** module.)

There are no third‑party Composer or PHP library requirements. The **Webform**
module is optional: install it only if you want the ready-made Webform media
element — it is suggested, not required.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_form_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_form_element -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_form_element -y
```

That's all it takes. There is no required configuration and no settings page —
the new `media_library` form element is now available to any form. See
[How to use it](../index.md#how-to-use-it) for where it shows up.

## Verify it worked

Confirm the module (and core's Media Library) are enabled:

```bash
drush pm:list --status=enabled | grep -E 'media_library'
```

If you have the Webform module installed, edit a webform, add an element, and you
should find the media library element in the element picker.
