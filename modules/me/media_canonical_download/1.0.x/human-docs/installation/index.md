# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Media** module in use on your site (the module operates on media
  entities and their canonical routes).

There are no third‑party Composer or PHP library requirements, and no additional
contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/media_canonical_download -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_canonical_download -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_canonical_download -y
```

## Verify it worked

After enabling, follow the setup steps in the
[main guide](../index.md#how-to-use-it): switch on **Standalone media URLs** in
core's media settings, then check **Serve file directly** on a media type. Visit
the canonical URL of a media item of that type (for example `/media/1`) — it
should download the file rather than render the media page. Confirm the behaviour
is right for any restricted media, since the download follows media *view* access.
