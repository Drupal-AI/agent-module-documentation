# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module enabled, including its oEmbed support — the module's only
  declared dependency.
- Outbound connectivity to the image providers (Flickr, GIPHY, Getty Images) for
  oEmbed resolution; images load from those third parties in visitors' browsers.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_remote_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_remote_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_remote_image -y
```

Enabling the module registers the additional oEmbed image providers (Flickr,
GIPHY, Getty Images) with core's Media system.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media/types`) and add a media
type; the image oEmbed source(s) this module registers should be selectable as the
source. Create a media item of that type with a supported image URL and confirm it
embeds correctly.
