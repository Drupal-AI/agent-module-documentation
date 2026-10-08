# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** / **Field** display system, part of the standard install. No
  third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_image_media_attributes_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_image_media_attributes_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_image_media_attributes_formatter -y
```

Once enabled, the formatter is available in the **Manage display** settings for
image and media fields — select it and set the `fetchpriority` and `decoding`
options there.
