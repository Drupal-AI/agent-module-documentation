# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- These modules, which Composer/Drush will bring in as dependencies:
  - **File** (`file`) — core.
  - **Migrate** (`migrate`) — core.
  - **Content Translation** (`content_translation`) — core, for translatable
    country names.
  - **Token** (`token`) — contrib.
  - **SVG Image** (`svg_image`) — contrib, for handling SVG flag images.

Before you run the import you will also need a **taxonomy vocabulary** (or content
type) to receive the terms, with fields for the ISO‑2 code, ISO‑3 code, and a flag
image — see [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/countries_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Token, SVG Image,
and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/countries_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en countries_import -y
```

This also enables the required File, Migrate, Content Translation, Token, and SVG
Image modules if they are not already on.

## Verify it worked

Visit **Configuration → Content authoring → Countries import**
(`/admin/config/content/countries-import`) — you should see the import settings
form. From there, follow [Configuration](../configuration/index.md) to map fields
and run the import.
