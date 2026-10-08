# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) enabled — Drupal enables it automatically as
  a dependency when you turn on Lite YouTube embed.
- Paul Irish's **`lite-youtube-embed`** JavaScript/CSS library, installed into
  your site's `/libraries` directory (see below). This is **not** bundled with
  the module, and without it the facade will not become interactive.

There are no PHP extension requirements beyond core's.

## Install with Composer

From the project root:

```bash
composer require drupal/lite_youtube_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lite_youtube_embed -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lite_youtube_embed -y
```

## Add the required `lite-youtube` library

The module references the library from `/libraries/lite-youtube-embed/src`
(the files `lite-yt-embed.js` and `lite-yt-embed.css`). You have two ways to get
it there:

- **Manually** — download Paul Irish's
  [lite-youtube-embed](https://github.com/paulirish/lite-youtube-embed) and place
  it so the files live at `web/libraries/lite-youtube-embed/src/lite-yt-embed.js`
  (and `.css`).
- **With Composer / Asset Packagist** — require `npm-asset/lite-youtube-embed`
  together with `oomphinc/composer-installers-extender` (configured to install
  npm assets into the `libraries` directory). These are listed as *suggested*
  packages by the module.

If the library is missing, the `<lite-youtube>` element still appears in the
markup but stays a static placeholder — clicking it does nothing.

## Verify it worked

Enable the formatter on a media type as described in
[How to use it](../index.md#how-to-use-it), then view a page with a YouTube
Remote video. You should see a thumbnail with a play button that only loads the
full YouTube player when clicked. There is no configuration page to visit — this
module has no settings form of its own.
