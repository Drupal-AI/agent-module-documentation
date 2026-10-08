# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Video Embed Field** module (`video_embed_field`) — this is a required
  dependency and provides the actual field type, widget, formatters and
  thumbnail handling. This add-on only teaches it about Facebook.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/video_embed_facebook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Video Embed
Field and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/video_embed_facebook -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en video_embed_facebook -y
```

Drupal enables the required Video Embed Field module automatically as a
dependency. The module ships no submodules and has no configuration — once
enabled, Facebook URLs are accepted by any Video Embed Field. See
[How to use it](../index.md#how-to-use-it) for adding a video field, and note
the compatibility caveat on the [overview page](../index.md) for this version.
