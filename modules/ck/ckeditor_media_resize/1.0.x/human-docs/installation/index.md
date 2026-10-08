# Installation

## Requirements

CKEditor5 Media Resize needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled.
- Core's **Media Library** module (`media_library`) enabled.

Drupal enables those core modules automatically as dependencies. There are no third-party
Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_media_resize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_media_resize -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_media_resize -y
```

Enabling the module installs its four image styles (`cke_media_resize_small` /`_medium`
/`_large` /`_xl`) and matching media view modes, but **does nothing to your text formats on
its own** — resizing only becomes available once you enable it on a specific CKEditor 5 text
format. See [Configuration](../configuration/index.md).
