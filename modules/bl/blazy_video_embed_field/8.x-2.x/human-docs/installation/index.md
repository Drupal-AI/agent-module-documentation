# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Video Embed Field** (`video_embed_field`, specifically the `video_embed_media`
  piece) — required.
- **Blazy** (`blazy`), version **8.x-2.x or newer** — required.

Both dependencies must be present and enabled; this module only adds formatters on
top of them.

## Install with Composer

From the project root:

```bash
composer require drupal/blazy_video_embed_field -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Blazy and Video Embed Field
along with any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/blazy_video_embed_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blazy_video_embed_field -y
```

Drupal enables the required Video Embed Field and Blazy modules as dependencies.
Once enabled, pick the Blazy formatter on your Video Embed field's **Manage
display** screen — see [How to use it](../index.md#how-to-use-it).
