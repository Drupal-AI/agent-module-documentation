# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** (`field`) and **Image** (`image`) modules — the image
  dependency is for the audio thumbnails. Drupal enables both automatically as
  dependencies.

> **A note on the version number.** The release version is **11.1.1**, tracking
> core's major rather than the usual contrib versioning scheme. That is a
> deliberate (and unusual) signal from the maintainer, not a mistake.

## Install with Composer

From the project root:

```bash
composer require drupal/audio_embed_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audio_embed_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en audio_embed_field -y
```

## Submodule — media integration

**Audio Embed Media Core** (`audio_embed_media_core`) makes embedded audio URLs
available as core Media entities, so they show up in the media library and can be
inserted in a WYSIWYG. Enable it only if you want that integration:

```bash
drush en audio_embed_media_core -y
```
