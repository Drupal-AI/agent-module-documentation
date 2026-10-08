# Installation

## Requirements

ImageMagick 5.0.x needs **Drupal core 11.3+** and two contrib modules, which
Composer pulls in automatically:

- **File metadata manager** (`file_mdm`, `^3.2`) — caches image metadata; an
  `imagemagick_identify` plugin reads image dimensions and format by calling the
  `identify` binary.
- **Sophron** (`sophron`, `^3`) — provides the file-extension → format → MIME
  type mapping the toolkit validates enabled formats against.

Both are enabled automatically as dependencies when you enable ImageMagick.

### The ImageMagick binary must be installed on the server

This is the most important requirement, and it is easy to miss. The module does
**not** bundle an image processor — it drives a command-line program that has to
be installed on the server operating system. You need **one** of:

- **ImageMagick** — provides the `convert` and `identify` commands (v6 or v7).
- **GraphicsMagick** — provides the `gm` command.

If neither binary is present, you can still install and enable the module, but
selecting the ImageMagick toolkit will fail its path check and image processing
will not work. On a Debian/Ubuntu server you would typically install ImageMagick
with `apt-get install imagemagick`; other platforms have their own packages.

> **Using DDEV?** Good news — DDEV's `web` container image already ships with
> ImageMagick installed, so the `convert` binary is available out of the box and
> you do not need to install it yourself. You can confirm with
> `ddev exec which convert`.

## Install with Composer

From the project root:

```bash
composer require drupal/imagemagick -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install/update the
`file_mdm` and `sophron` dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imagemagick -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagemagick -y
```

This also enables `file_mdm` and `sophron`. Enabling the module does **not**
change your active image toolkit on its own — Drupal keeps using GD until you
select ImageMagick on the toolkit page.

## Verify it worked

Log in as an administrator and go to **Configuration → Media → Image toolkit**
(`/admin/config/media/image-toolkit`). Under **Select an image processing
toolkit** you should now see a new **ImageMagick image toolkit** radio option
alongside the existing **GD2 image manipulation toolkit**. If that option is
present, the module is installed correctly. Next, follow
[Configuration](../configuration/index.md) to select and set it up.
