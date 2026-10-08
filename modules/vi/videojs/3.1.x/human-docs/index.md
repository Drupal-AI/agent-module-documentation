# Video.js Player — manual setup guide

**Video.js Player** (`videojs`) plays your uploaded videos with the popular
[Video.js](https://videojs.com/) HTML5 player. It adds two **field formatters**
that turn a File field or a Video reference field into a `<video>` element
styled and controlled by Video.js, so instead of the browser's default player
your visitors get a consistent, cross-device video experience. The player
library loads from a public CDN by default, so there is nothing to download to
get started.

You use it by choosing one of its formatters on an entity's **Manage display**
tab for any file or video field. `videojs_player` handles single-value fields;
`videojs_player_list` handles multi-value fields, rendering one player that
offers each uploaded file as an alternative `<source>` (for example an MP4 with
a WebM fallback, letting the browser pick a format it supports). Each formatter
has its own per-display settings — width, height, whether controls show, and
autoplay, loop, muted, and preload behavior.

There is **no admin settings form** and no permissions; everything is configured
per display. Advanced users can point the module at a self-hosted copy of the
library through the `videojs.settings` config object (set with Drush or config
import — see below), but most sites simply use the default CDN.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. All configuration happens on each entity's
**Manage display** tab (for example
`/admin/structure/types/manage/article/display`), where you pick a Video.js
formatter for your file or video field.

## How to use it

1. Make sure your content type has a **File** field (accepting video files like
   MP4/WebM/Ogg) or a **Video** reference field.
2. Go to that content type's **Manage display** tab.
3. For the video field, open the **Format** dropdown and choose **Video.js
   Player** (use the list variant for a multi-value field), then click the cog
   to set options:
   - **Width** / **Height** — the player size in pixels (defaults 854 × 480),
     written to the element's inline style.
   - **Controls** — show the play/scrub/volume controls (on by default).
   - **Autoplay** — start playing on load. Browsers block autoplay with sound,
     so pair this with **Muted** for background or hero videos.
   - **Loop** — replay the clip continuously.
   - **Muted** — start silent.
   - **Preload** — how much the browser fetches up front: **none**,
     **metadata**, or **auto**. Lower settings save bandwidth on page load.
4. Save. The field now renders as a Video.js player.

For a multi-value field, the **list** formatter produces a single player with
one `<source>` per uploaded file, so you can supply the same video in several
codecs and let the browser choose.

### Serving the library locally (optional)

By default the player loads from the Video.js CDN, so nothing needs to be
installed. If you must self-host, the module stores the library location in the
`videojs.settings` config object, which has **no admin form** — set it with
Drush:

```bash
drush config:set videojs.settings videojs_location local -y
drush config:set videojs.settings videojs_directory 'libraries/video-js' -y
```

Note that the asset actually loaded is defined in the module's
`videojs.libraries.yml`, which points at the Video.js 5.x CDN. To fully
self-host you override that library (via `hook_library_info_alter` or a theme
`libraries-override`) to point at your local copy.
