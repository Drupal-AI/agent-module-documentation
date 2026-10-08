# Media Entity Soundcloud — manual setup guide

**Media Entity Soundcloud** (`media_entity_soundcloud`) adds a **SoundCloud media source**
to Drupal core's Media module. That lets you create a media type whose items are SoundCloud
tracks or playlists — entered simply as a URL — and render them as embedded players. Editors
paste a SoundCloud link, and the site turns it into a proper, reusable Media entity with an
embedded player, a stored thumbnail, and all the usual Media benefits (revisions,
permissions, Media Library, referencing from other content).

Under the hood, the module provides a Media source plugin with the id `soundcloud`. You
create a media type, choose "Soundcloud" as its source, and give it a source field to hold
the track/playlist URL. From that URL the source calls SoundCloud's public oEmbed endpoint
to derive metadata — the track or playlist id, the raw embed HTML, and a thumbnail image
that it downloads locally. A companion field formatter, **Soundcloud embed**, renders the
media as a responsive `<iframe>` player with configurable type (visual or classic), width,
height, brand color, and a long list of player options (autoplay, hide related tracks, show
artwork/play count/comments, download/buy/share buttons, and "single active" so only one
player on a page plays at a time).

There is **no admin settings page** — everything is configured through the media type, its
source field, and the display formatter. The only module‑level configuration is a single
value that controls where fetched thumbnails are stored. Editors can add items by pasting a
URL into the source field or through the Media Library "add" form, which validates that the
URL is a reachable soundcloud.com link. The embed markup is themeable via a template if you
want to customise the iframe.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

You configure SoundCloud through a **media type**, its **source field**, and the **display
formatter** — there's no central settings page.

### 1. Create a SoundCloud media type

1. Go to **Structure → Media types → Add media type** (`/admin/structure/media/add`).
2. Give it a name (e.g. "Podcast" or "Audio").
3. Set **Media source** to **Soundcloud**. Save.
4. The source needs a **source field** — a text (`string`/`string_long`) or `link` field —
   to hold the SoundCloud URL. Confirm or choose it in the type's source settings. (Drupal
   can create a default URL field for you.)

### 2. Set up the embed display

1. Open the type's **Manage display**
   (`/admin/structure/media/manage/<your-type>/display`).
2. Set the source field's **Format** to **Soundcloud embed**.
3. Click the cog to choose the player options:
   - **type** — *visual* (large artwork player) or *classic* (compact, ~166px),
   - **width** (default `100%`) and **height** (default `450`),
   - **color** — the play‑button brand color (default `#ff5500`),
   - the **options** checkboxes — autoplay, hide related, show artwork/play count/comments/
     uploader/reposts, download/buy/share buttons, teaser, single active, and so on.
4. Save.

### 3. Add SoundCloud items

Editors add a SoundCloud track or playlist by entering its URL in the source field, or via
the **Media Library** "Add Soundcloud Track URL" form, which checks that the URL is a valid,
reachable soundcloud.com link. You can then reference the media from articles, podcast
episodes, or artist profiles, or build a Views listing of it (a podcast archive, for
example).

### Thumbnail storage (the one module setting)

The module has a single configuration value, `thumbnail_destination`, that sets the
directory where thumbnails fetched from SoundCloud are saved (default
`public://soundcloud`). There's no form for it, but you can change it with Drush:

```bash
drush cget media_entity_soundcloud.settings thumbnail_destination
drush cset media_entity_soundcloud.settings thumbnail_destination 'public://audio_thumbs' -y
```
