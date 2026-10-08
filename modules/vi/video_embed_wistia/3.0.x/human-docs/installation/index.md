# Installation

## Requirements

- **Drupal 10 or 11** (the release requires `drupal/core: ^10 || ^11`).
- **Video Embed Field** (`drupal/video_embed_field`, version `^3.0`), which is a
  hard dependency — this module is an add‑on provider for it.

There are no third‑party PHP library requirements, and Wistia videos are fetched
directly from Wistia's public embed and oEmbed endpoints (no API key needed).

## Install with Composer

From the project root:

```bash
composer require drupal/video_embed_wistia -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in **Video Embed
Field** and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/video_embed_wistia -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en video_embed_wistia -y
```

Enabling it also enables **Video Embed Field** if it isn't already on. There are no
submodules and no configuration step — "Wistia" immediately becomes an available
provider.

## Verify it worked

Edit a piece of content that has a Video Embed Field, paste a Wistia video URL
(such as `https://yourname.wistia.com/medias/abc123`), and save. The video should
render as a Wistia iframe when you view the content, and its thumbnail should appear
on teaser displays. See the [overview](../index.md) for more on how it fits into
Video Embed Field.
