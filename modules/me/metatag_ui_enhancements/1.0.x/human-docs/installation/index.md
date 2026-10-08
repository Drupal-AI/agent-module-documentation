# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- The **Metatag** module (`metatag`) — required.
- Core's **Media Library** module (`media_library`) — required; core provides it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_ui_enhancements -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Metatag if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag_ui_enhancements -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_ui_enhancements -y
```

This enables Metatag and Media Library as dependencies if they are not already on.

## Verify it worked

Edit a piece of content and confirm the **"SEO and social media"** tab appears with
the enhanced title/description/image controls, and that images can be selected via
the Media Library. Set a default and a generic fallback image in the Metatag
configuration, then share a page link to confirm the preview shows the expected
title, description, and image.
