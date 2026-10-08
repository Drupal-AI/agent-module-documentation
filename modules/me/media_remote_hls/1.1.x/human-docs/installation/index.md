# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Media Remote** (`media_remote`) module, which this module extends and
  depends on — install it alongside this module (Composer handles it with `-W`).
- An HLS stream URL ending in `.m3u8` (from AWS MediaLive/CloudFront, your own HLS
  server, or any HLS source), reachable from your visitors' browsers.

There are no PHP library requirements. The player is **Video.js** with the default
skin in this version.

## Install with Composer

From the project root:

```bash
composer require drupal/media_remote_hls -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including Media Remote — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_remote_hls -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_remote_hls -y
```

Drupal will enable the Media Remote dependency at the same time.

## Verify it worked

Add a media type using the **Remote Media URL** source, set its **Manage display**
formatter to **Media Remote - HLS** (see the [overview](../index.md)), then create
a media item with an `.m3u8` URL. View it and confirm the HLS stream plays in the
Video.js player.
