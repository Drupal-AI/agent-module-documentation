# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module (`media`) — a dependency Drupal enables automatically.

There are no third‑party library or manual Composer steps: the module bundles the
lightGallery assets it needs.

## Install with Composer

From the project root:

```bash
composer require drupal/lightgallery_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lightgallery_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lightgallery_formatter -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Preview** | `lightgallery_formatter_preview` | Adds a live‑preview tab to the profile configuration so you can see a gallery render while you edit a profile's settings. |
| **Demo** | `lightgallery_formatter_demo` | Creates a content type and demo nodes so you can try the formatter with ready‑made sample content. |

Enable them individually, for example:

```bash
drush en lightgallery_formatter_preview -y
```

## Verify it worked

Create a gallery profile (see [Configuration](../configuration/index.md)), then on
a media field's **Manage display** choose **LightGallery Formatter** and select
that profile. Visit a page showing the field and click a thumbnail — it should
open the lightGallery lightbox.
