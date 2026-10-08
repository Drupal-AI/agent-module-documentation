# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) — the only dependency, enabled automatically.
- A media type with the core oEmbed video field (`field_media_oembed_video`) —
  the core **Remote video** type provides this. Enable core's **Media Library**
  too if you want the CKEditor embed workflow.
- **Internet access to unpkg.com** at render time, because the micromodal.js
  library loads from that public CDN by default. For an offline or locked‑down
  site, override the `micromodal` library to a self‑hosted copy with
  `hook_library_info_alter()`.
- There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_video_micromodal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_video_micromodal -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_video_micromodal -y
```

## After enabling

There is no settings page and no permissions of its own. The new **Video
Micromodal** formatter is immediately available on the **Manage display** tab of
any remote‑video media type — see the [main guide](../index.md) for how to apply
it.
