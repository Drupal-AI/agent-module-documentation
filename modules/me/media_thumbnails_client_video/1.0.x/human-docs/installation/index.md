# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The [Media Thumbnails](https://www.drupal.org/project/media_thumbnails) module
  (`media_thumbnails`) — this is the framework the plugin registers with. Composer
  pulls it in with the command below.

No server-side video tools (FFmpeg and the like) are needed — thumbnail generation
runs in the browser. Modern browsers with HTML5 video and canvas support are
required on the editor's side.

## Install with Composer

From the project root:

```bash
composer require drupal/media_thumbnails_client_video -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Media Thumbnails — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_thumbnails_client_video -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_thumbnails_client_video -y
```

Drupal will enable **Media Thumbnails** at the same time if it is not already on.

## Verify it worked

Upload a video through a Media entity form and save it — the media should receive a
thumbnail captured from an early frame of the video. You can also confirm the
**Regenerate Thumbnail** tab appears on the media entity's edit page. See
[How to use it](../index.md#how-to-use-it) for the full workflow.
