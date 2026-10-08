# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **`symfony/property-access`** and the **Cloudinary PHP SDK (2.11+)** — both are
  pulled in automatically when you install via Composer.
- A **Cloudinary account** (cloud name, API key, API secret) — sign up at
  [cloudinary.com](https://cloudinary.com/).

## Install with Composer

From the project root:

```bash
composer require drupal/cloudinary -W
```

The Cloudinary PHP SDK is installed automatically as a dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudinary -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en cloudinary -y
```

## Submodules — enable only what you need

Cloudinary is a suite. Enable submodules individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **SDK** | `cloudinary_sdk` | The supporting Cloudinary PHP SDK integration used by the other submodules. |
| **Stream Wrapper** | `cloudinary_stream_wrapper` | A `cloudinary://` stream wrapper so files uploaded through Drupal's normal file API go straight to Cloudinary. |
| **Storage** | `cloudinary_storage` | Caches Cloudinary's remote file structure locally to reduce network requests. Has its own sub‑variants for DB, filesystem, MongoDB and Redis backends. |
| **Media Library Widget** | `cloudinary_media_library_widget` | A Media source plus a Cloudinary media‑library widget for browsing/selecting assets. |
| **Video** | `cloudinary_video` | HTML5 video and Cloudinary player integration. |
| **Source Migrate** | `cloudinary_source_migrate` | Tools for migrating existing media sources into Cloudinary. |

For a typical setup that offloads uploads, enable the stream wrapper:

```bash
drush en cloudinary_stream_wrapper -y
```

## Verify it worked

Go to **Configuration → Media → Cloudinary** and enter your credentials (see
[Configuration](../configuration/index.md)). Once credentials are saved, create or
edit an image style at **Configuration → Media → Image styles** and confirm that
rendered images are delivered through Cloudinary's URLs.
