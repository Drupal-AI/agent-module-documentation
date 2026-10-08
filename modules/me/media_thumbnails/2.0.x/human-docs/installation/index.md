# Installation

## Requirements

Media Thumbnails has no third-party libraries. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Media** module (`media`), enabled automatically as a dependency.

Remember that this module is a *framework* — on its own it generates no thumbnails.
To produce previews you also need at least one **generator plugin** for the file
types you care about. Some formats need external tooling on the server (for example
ImageMagick or similar) depending on which generator you install — check the
generator module's own requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_thumbnails -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_thumbnails -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_thumbnails -y
```

There are no submodules bundled with this release.

## Add a generator plugin

Because the base module ships no generators, install one (or more) for your file
types. Generators for common formats are separate contrib projects — for example a
PDF thumbnail generator:

```bash
composer require drupal/media_thumbnails_pdf -W
drush en media_thumbnails_pdf -y
```

(Search drupal.org for the generator that matches your format, or write a custom
`@MediaThumbnail` plugin as described in the [`agent/`](../agent/start.md) docs.)

## Grant the permission (optional)

Only users with **Manage media thumbnails settings** can open the settings and
refresh pages. To grant it to a media-manager role:

```bash
drush role:perm:add media_manager 'manage media thumbnails settings'
```

## Verify it worked

Upload a media item of a type your generator handles (for example a PDF) and check
the media library — you should see a real preview instead of a generic icon. If
existing media still shows icons, run `drush thumbnails:refresh` once. Then adjust
the width and other options under **Configuration → Media → Media Thumbnails** as
described in the [overview](../index.md#how-to-use-it).
