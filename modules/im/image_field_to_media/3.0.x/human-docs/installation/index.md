# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module enabled — the only dependency, and Drupal enables it automatically.
- An **`image` Media type with a `field_media_image` field** must exist before you convert
  anything. This is the standard Image media type Drupal creates when you set up media; the
  module checks for it and refuses to proceed with a clear message if it is missing. See
  [Configuration](../configuration/index.md).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_field_to_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_field_to_media -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_field_to_media -y
```

## Grant the permission

The module defines one permission — **Create media fields based on existing image fields**
(marked *restricted*, because it creates fields and Media entities). Grant it only to trusted
administrator roles. Once granted, the **"Clone to media"** operation appears on Image fields
in *Manage fields*. See [Configuration](../configuration/index.md) for the full walkthrough.
