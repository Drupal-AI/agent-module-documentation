# Installation

## Requirements

WebP needs:

- **Drupal core's Image module** (`image`) — WebP hooks into the image-style
  pipeline, so core Image must be enabled. It ships with Drupal and WebP enables it
  as a dependency.
- **The PHP GD extension** (`ext-gd`) — WebP builds its `.webp` copies with the GD
  image toolkit, so PHP's GD extension is a hard requirement (Composer lists it in
  the module's requirements).

Because the module writes WebP files through GD, **your server's image toolkit must
be able to write WebP**. In practice this means GD compiled with WebP support (the
`ext-gd` requirement above); some sites instead run the ImageMagick toolkit, in
which case that toolkit must likewise be able to output WebP. Most modern PHP builds
include GD with WebP support out of the box.

## Install with Composer

From the project root:

```bash
composer require drupal/webp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/webp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webp -y
```

This also enables core's **Image** module if it is not already on. Once enabled, the
settings page appears under **Configuration → Media → WebP**
(`/admin/config/media/webp/settings`).

## Verify it worked

Log in as an administrator and go to `/admin/config/media/webp/settings`. You should
see the **WebP settings** page with a single **Image quality** field. If that page
loads, the module is installed correctly. Next, review the
[configuration](../configuration/index.md).
