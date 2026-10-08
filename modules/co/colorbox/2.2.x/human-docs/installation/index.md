# Installation

## Requirements

Colorbox needs **Drupal 10.2+ or 11** and core's **Image** module (`image`),
which ships with Drupal and is enabled automatically as a dependency. There are no
other contrib module requirements.

It does, however, need one extra piece that is **not** a Drupal module: the
external **Colorbox JavaScript library** (the jQuery plugin itself). The Drupal
module only integrates that library — the lightbox will not work until the library
is present on disk. Installing it is covered below.

## Install with Composer

From the project root:

```bash
composer require drupal/colorbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/colorbox -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colorbox -y
```

This also enables core's `image` module. Once enabled, the settings screen appears
under **Configuration → Media → Colorbox** (`/admin/config/media/colorbox`).

## Add the Colorbox JavaScript library

The module ships with a Drush command that downloads and installs the library for
you. From the project root:

```bash
drush colorbox:plugin
```

With no argument it installs the library into `libraries/colorbox` in your Drupal
root (pass a path to override that location). It fetches the archive from the
library's remote URL and skips the download if the target directory already exists.
If you prefer, you can download the library archive by hand and unpack it into
`libraries/colorbox` yourself — the module looks for it in the same place either
way.

> **Optional — HTML captions.** Colorbox can also make use of the **DOMPurify**
> library, which is only needed if you want to use HTML in lightbox captions.
> Without it, captions are shown as plain text and Drupal's status report notes the
> library is missing. You can safely ignore this if plain-text captions are fine.

## Verify it worked

Log in as an administrator and go to `/admin/config/media/colorbox`. You should see
the **Colorbox settings** page with a **Styles and options** section and a **Save
configuration** button:

![The Colorbox settings page after installation](../images/settings.png)

If the page loads, the module is installed. Next, review the
[configuration](../configuration/index.md) and switch an image field over to the
Colorbox display.
