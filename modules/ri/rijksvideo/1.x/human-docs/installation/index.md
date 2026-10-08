# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **File** (`file`), **Media** (`media`), and **Media Library**
  (`media_library`) modules — these are Rijksvideo's dependencies and Drupal will
  enable them automatically.
- Access to **Rijksvideo XML exports** from Rijksbeeldbank, which are what you
  upload to create video media.

There are no third-party Composer or PHP library requirements. Note this module is
**minimally maintained** (maintenance fixes only).

## Install with Composer

From the project root:

```bash
composer require drupal/rijksvideo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rijksvideo -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rijksvideo -y
```

Drupal enables the File, Media, and Media Library dependencies at the same time.

## Verify it worked

Log in as an administrator and go to **Content → Media → Add media**. You should
see **Rijksvideo** as an available media type. Create one by uploading a
Rijksvideo XML file and confirm the fields populate automatically from the XML.
From there, see the "How to use it" section of the [overview](../index.md) for
placing the media and choosing its display.
