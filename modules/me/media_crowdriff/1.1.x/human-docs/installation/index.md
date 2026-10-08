# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module enabled (and the **Media Library** module if you want the
  Embed Code add form in the media library). Media Crowdriff is a core-Media
  integration, so Media must be on for it to do anything.

There are no third-party Composer libraries to install. At display time the module
loads Crowdriff's own JavaScript from `starling.crowdriff.com`, so the browser needs
access to that host for galleries to render.

## Install with Composer

From the project root:

```bash
composer require drupal/media_crowdriff -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/media_crowdriff -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_crowdriff -y
```

Make sure core **Media** (and, for the library workflow, **Media Library**) is
enabled too:

```bash
drush en media media_library -y
```

Enabling the module makes the **Media Crowdriff** source available; it does not create
a media type for you. To finish setup, add a media type that uses the Crowdriff source
as described in [the overview](../index.md#how-to-use-it).
