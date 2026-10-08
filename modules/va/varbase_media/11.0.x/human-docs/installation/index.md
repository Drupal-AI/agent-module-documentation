# Installation

## Requirements

- **Drupal core `~11.4.0`** (`core_version_requirement: ~11.4.0`) — this release is
  pinned to that core branch.
- **DrImage (improved)** (`drimage_improved`) — the only declared dependency, used
  for responsive images. Composer installs it for you.
- Practically, the module expects the surrounding **Varbase distribution**: it
  references media types, image styles (`social_large`, `social_medium`,
  `social_small`), and fields (`field_media`, `field_image`, `field_video`,
  `field_media_image`) that Varbase provides but this module does not ship. It is
  intended as a Varbase feature module rather than a standalone add-on.

## Install with Composer

From the project root:

```bash
composer require drupal/varbase_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install DrImage (improved)
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/varbase_media -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en varbase_media -y
```

That is the whole setup — there is no configuration page. Enabling the module
activates its media behaviours and makes its share-image tokens available. See
[How to use it](../index.md#how-to-use-it) on the overview page for the tokens,
CKEditor 5 resize presets, and the video-player behaviour.
