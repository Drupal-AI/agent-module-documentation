# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) enabled — the only Drupal dependency, and it is
  enabled automatically as a dependency when you turn on Media: Webm.
- A **video encoder available on the server**, typically **FFmpeg**. The module
  shells out to the encoder to perform the MP4→WebM conversion, so this must be
  installed and reachable on the host that runs the queue.

There are no additional Composer or PHP library requirements.

> **DDEV note.** DDEV's web container includes FFmpeg by default, so in a standard
> DDEV setup the encoder is already present. On other hosting, confirm FFmpeg is
> installed (for example `ffmpeg -version`) before relying on conversions.

## Install with Composer

From the project root:

```bash
composer require drupal/media_webm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_webm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_webm -y
```

## Verify it worked

After wiring the WebM formatter onto your video media type (see "How to use it" on
the [overview page](../index.md)), upload an MP4 video, then run the conversion
queue:

```bash
drush queue:run media_webm_converter
```

Once the job completes, the media item should display with a WebM derivative
available. If conversion never completes, check that FFmpeg is installed and that
your cron (or the manual command above) is actually processing the
`media_webm_converter` queue.
