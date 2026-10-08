# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party Composer libraries and no other contrib module dependencies. It
  uses core's file-field and HTML5 media elements.

> The current release is a beta (**1.1.0-beta1**) — test it on a non-production
> environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/audio_video_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audio_video_viewer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en audio_video_viewer -y
```

Then select the **Audio Video Viewer** formatter on a file field's **Manage
display** tab. See [How to use it](../index.md#how-to-use-it).
