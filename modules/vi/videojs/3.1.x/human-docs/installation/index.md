# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **File** and/or **Media** fields to attach the formatter to (any `file`
  or `video` field works).
- No other modules are required. The Video.js JavaScript library is loaded from
  a CDN by default, so there is **nothing to download** to get started. (The
  module lists `videojs/video.js` as an asset-library dependency, but the shipped
  library definition pulls it from the CDN.)

## Install with Composer

From the project root:

```bash
composer require drupal/videojs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/videojs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en videojs -y
```

That's all it takes. There is no required configuration — head to any content
type's **Manage display** tab and choose the **Video.js Player** formatter for a
file or video field. See the [overview](../index.md#how-to-use-it) for the
per-display options.
