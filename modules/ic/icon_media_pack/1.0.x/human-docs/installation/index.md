# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11`; the
  project also declares support up to Drupal 12).
- Core's **Media** module (`media`).
- The contrib **UI Icons** modules — **UI Icons** (`ui_icons`) and **UI Icons
  Media** (`ui_icons_media`). Composer installs these for you.
- No PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/icon_media_pack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the UI Icons modules — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/icon_media_pack -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en icon_media_pack -y
```

This enables Media, UI Icons, and UI Icons Media as dependencies.

## Verify it worked

With a media bundle of icons defined as an icon pack (see
[How to use it](../index.md#how-to-use-it)), open any icon picker in the admin UI
— for example when adding an icon to a menu link — and confirm your media‑backed
icon collection appears among the available icon sets.
