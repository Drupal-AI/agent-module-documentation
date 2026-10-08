# Installation

> **⚠️ Obsolete module.** This module is no longer maintained; its functionality has
> been replaced by the **Orejime Media** module. For new projects, install Orejime
> Media instead. These instructions are for existing sites that still use Orejime
> Compliant Videos.

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core **Media** (`media`) — a dependency, enabled automatically.
- The **Orejime** consent‑manager module/library must be installed and running, with
  matching consent "apps" defined.
- **Optional:** the Video Embed Field module, if you enable the `orejime_videos_vef`
  submodule.

There are no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/orejime_videos -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/orejime_videos -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en orejime_videos -y
```

To also gate Video Embed Field videos, enable the submodule:

```bash
drush en orejime_videos_vef -y
```

## Verify it worked

Enabling the module doesn't gate anything by itself — you must turn on the text filter
and/or the oEmbed formatter. After configuring one of them (see the
[main guide](../index.md)), view a page with an embedded video as a visitor who has
**not** consented: you should see the placeholder instead of the video. Grant the
matching Orejime consent and the video should appear. Defaults ship for YouTube,
Vimeo, and Twitter.
