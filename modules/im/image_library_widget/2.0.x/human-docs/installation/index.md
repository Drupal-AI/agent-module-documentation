# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Media** module (`media`).
- Core's **Views** module (`views`).

Both dependencies are enabled automatically when you turn on Image Library Widget.
(The project historically also noted a PHP 7.1+ minimum; any supported Drupal
10.2/11 environment comfortably exceeds this.)

## Install with Composer

From the project root:

```bash
composer require drupal/image_library_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_library_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_library_widget -y
```

This also enables the Media and Views modules if they aren't already on.

## Verify it worked

After enabling, follow the setup in the main guide's "How to use it": create an
Image media type whose source field is `media.image_library_widget_image`, add a few
media entries, then set an image field's widget to **Image Library Widget** on
**Manage form display**. Editing that field should show both an upload control and a
browsable library of your existing images.
