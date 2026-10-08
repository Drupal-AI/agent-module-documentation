# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- The **AMP** module (`amp`) and **Video Embed Field** (`video_embed_field`),
  plus core **Field** (`field`) and **Image** (`image`). These are hard
  dependencies — the formatter only makes sense with the AMP module handling AMP
  pages and Video Embed Field providing the video field.

Install AMP and Video Embed Field first if they are not already present:

```bash
composer require drupal/amp drupal/video_embed_field -W
```

## Install with Composer

From the project root:

```bash
composer require drupal/amp_video_embed_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/amp_video_embed_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en amp_video_embed_field_formatter -y
```

There is no settings page to configure. Once enabled, assign the AMP video
formatter on a Video Embed Field field's **Manage display** screen, as described
in the [overview](../index.md).
