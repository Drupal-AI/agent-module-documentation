# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **CKEditor 5** module (`ckeditor5`) — this is a direct
  dependency and will be enabled with the module.
- Core's **Media Library** in use, since the plugin currently targets embedded
  media.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_inline_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_inline_styles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_inline_styles -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, edit a
CKEditor 5 format, and confirm the **Media Inline Styles** icon appears in the
*Available toolbar items* and that an **Inline Style** filter is listed under
*Enabled filters*. Follow the toolbar and filter-order steps in the main guide,
save, and check that applied styles survive when you save content.
