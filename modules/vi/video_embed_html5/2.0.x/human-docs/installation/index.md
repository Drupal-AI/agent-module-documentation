# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- The **Video Embed Field** module (`drupal/video_embed_field`, `^2.5 || ^3.0`) —
  this module is an add‑on provider for it, so it must be present. Composer pulls
  it in for you automatically.
- **Optional:** [php_ffmpeg](https://www.drupal.org/project/php_ffmpeg) for
  server‑side generation of video thumbnails. Without it, thumbnails are generated
  in the browser instead.

## Install with Composer

From the project root:

```bash
composer require drupal/video_embed_html5 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Video Embed Field
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/video_embed_html5 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en video_embed_html5 -y
```

Drupal enables Video Embed Field at the same time as a dependency. There are no
submodules.

## After enabling

The HTML5 provider is available immediately on every Video Embed field — just
paste a direct `.mp4`, `.ogg`, or `.webm` link. See the [main page](../index.md)
for how to embed a video, restrict a field to HTML5 only, and configure the
placeholder image.
