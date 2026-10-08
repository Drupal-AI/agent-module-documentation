# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) and **Responsive Image** module
  (`responsive_image`). Drupal enables them as dependencies when you turn on Media
  Text Overlay.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_text_overlay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_text_overlay -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_text_overlay -y
```

## Verify it worked

Go to an entity that has an image field, open its **Manage display** tab, and confirm
the module's **text overlay** formatter appears in the format dropdown for that
field. Selecting it, entering some overlay text on a piece of content, and viewing
the result should show the text positioned over the image. The rest of the setup is
in [How to use it](../index.md#how-to-use-it).
