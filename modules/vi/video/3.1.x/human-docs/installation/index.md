# Installation

## Requirements

- **Drupal 10.2 or newer** (`core_version_requirement: >=10.2`), including
  Drupal 11.
- Core's **File** module (`file`) — the only dependency, and Drupal enables it
  automatically. The `video` field type extends core's file field.

There are no third‑party Composer requirements. If you want to store video files
on remote/cloud file systems, the
[Flysystem](https://www.drupal.org/project/flysystem) module is recommended but
optional. The **Video Transcode** submodule additionally needs **FFmpeg**
available on the server if you enable it.

## Install with Composer

From the project root:

```bash
composer require drupal/video -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/video -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en video -y
```

That's all that's required. There is no settings page to visit afterward — you
add and configure a Video field directly on a content type (see the
[overview](../index.md#how-to-use-it)).

## Submodule — Video Transcode

Video ships one optional submodule, **Video Transcode** (`video_transcode`),
which adds local **FFmpeg** transcoding of uploaded videos into web‑friendly
formats using reusable presets (codec, bitrate, resolution, watermark). It also
provides a "Video Upload & Convert" widget that uploads and queues conversion in
one step. Enable it only if you need transcoding and have FFmpeg installed:

```bash
drush en video_transcode -y
```

## Verify it worked

Go to **Structure → Content types**, edit any type, open **Manage fields → Add
field**, and confirm that **Video** appears as a field type you can add.
