# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **[Video Embed Field](https://www.drupal.org/project/video_embed_field)
  `^3.1`** — this is a required dependency. Composer pulls it in automatically,
  and Drupal enables it as a dependency when you turn on this module.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/video_embed_dailymotion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Video Embed
Field and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/video_embed_dailymotion -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en video_embed_dailymotion -y
```

Or enable **Video Embed Field Dailymotion** from **Extend**
(`/admin/modules`) — Video Embed Field is enabled at the same time if it is not
already on.

That's all that is needed. Dailymotion is now a recognised provider on any Video
Embed Field. There is no configuration page and no submodules.
