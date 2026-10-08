# Installation

## Requirements

Juicebox needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (`file`) and **Image** module (`image`) — enabled
  automatically as dependencies.
- The external **Juicebox JavaScript library** — see below. This is **not** a
  Composer dependency; you download and place it yourself.

> **Note on the release:** the installed 4.0.x release is `4.0.0-alpha2`, an
> alpha. Pin explicitly if you depend on it.

## Install with Composer

From the project root:

```bash
composer require drupal/juicebox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/juicebox -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en juicebox -y
```

Enabling the module also installs four ready-made image styles you can use for
galleries: `juicebox_small`, `juicebox_medium`, `juicebox_large`, and
`juicebox_square_thumb`.

## Add the Juicebox JavaScript library (required for a live gallery)

The gallery itself is drawn by the Juicebox JavaScript library, which is licensed
and distributed separately from the Drupal module:

1. Download Juicebox from <https://juicebox.net/download/> — the **Lite** edition
   is free; **Pro** is paid and unlocks extra options.
2. Place its `juicebox.js` file under `/libraries/juicebox/` in your web root (so
   the file is at `/libraries/juicebox/juicebox.js`).

Without this library, you can still configure the formatter and Views style and
the XML feed still emits — but the client-side gallery will not appear. Add the
library and clear caches to see live galleries.

## Next steps

Once the module and library are in place, configure a gallery display and the
global settings — see [Configuration](../configuration/index.md).
