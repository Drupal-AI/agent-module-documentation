# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[Video Embed Field](https://www.drupal.org/project/video_embed_field)**
  module (`video_embed_field`) — this module is a provider plugin for it and does
  nothing on its own.
- *(Optional)* A **Youku API Client ID** from the
  [Youku Developer Portal](https://open.youku.com/) if you want the module to
  fetch remote titles, descriptions, and thumbnails. The player embeds fine
  without it.

There are no extra Composer libraries or PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/video_embed_youku -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch Video Embed Field
(if it isn't already present) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/video_embed_youku -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with Video Embed Field (Drupal will offer to enable the
dependency automatically):

```bash
drush en video_embed_youku -y
```

## What to do next

The Youku provider is available to Video Embed Field immediately. To fetch remote
metadata, enter a Youku API Client ID on the settings page — see
[Configuration](../configuration/index.md).
