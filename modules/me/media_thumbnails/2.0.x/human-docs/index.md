# Media Thumbnails — manual setup guide

**Media Thumbnails** (`media_thumbnails`) generates real preview images for media
whose file types Drupal core can't preview on its own — PDFs, SVGs, ePubs, video,
and Office documents. Instead of a generic file icon in the media library, a PDF
shows its first page, an SVG is rasterized into a thumbnail, a video shows a poster
frame, and so on. It figures out which media to process by looking at each file's
MIME type.

The important thing to understand up front: **this module ships no thumbnail
generators of its own.** It is a *plugin framework* — it provides the machinery that
watches media being created, updated, and deleted, and dispatches each file to the
right generator plugin based on its MIME type. To actually get thumbnails, you
install (or write) at least one generator plugin for the file types you care about.
Generators for common formats like PDF are published as separate contrib projects
(for example `media_thumbnails_pdf`), and a custom `@MediaThumbnail` plugin is a
small class implementing a single `createThumbnail()` method.

Once a generator is present, thumbnails are produced automatically whenever media is
saved. A settings page controls the target width, an optional background color for
flattening transparency, and whether editor-supplied thumbnails should be protected
from being overwritten. A "Refresh" action (and a Drush command) re-generates every
thumbnail in one batch after you change settings or add a generator. It requires
core's **Media** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how to write your
own `@MediaThumbnail` plugin — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add a generator plugin.

## Where it lives in the admin menu

The settings page sits at **Configuration → Media → Media Thumbnails**
(`/admin/config/media/thumbnails`), with a **Refresh** tab beside it at
`/admin/config/media/thumbnails/refresh`. Both are gated by the **Manage media
thumbnails settings** permission.

## How to use it

### 1. Add a generator for your file types

By itself the module produces nothing. Install a contrib generator for the formats
you need (search drupal.org for "media thumbnails" companion modules, e.g. the PDF
generator), or write a custom plugin (see the [`agent/`](../agent/start.md) docs).
Each generator claims one or more MIME types; when media of that type is saved, its
thumbnail is generated.

### 2. Adjust the settings

On **Configuration → Media → Media Thumbnails** you'll find:

- **Width** — the target thumbnail width in pixels (default 500). Height is worked
  out by the generator to keep the aspect ratio. Changing this does **not** rebuild
  existing thumbnails — run the Refresh afterward (see below).
- **Background color active** — when on, transparent thumbnails are flattened onto
  a solid background color instead of keeping their transparency. Useful for a tidy,
  consistent media-library grid. Leave it off to preserve transparency.
- **Background color** — the hex color used for that flattening (default
  `#eeeeee`), chosen with a color picker.
- **No thumbnail update** — when on, saving a media entity won't overwrite its
  thumbnail — except when the current thumbnail is still just a generic icon. Turn
  this on to protect thumbnails your editors uploaded by hand.
- **Allow thumbnail edit** — when on, the media *Thumbnail* field becomes available
  on media forms so editors can upload or replace a thumbnail themselves. After
  enabling it, add the **Thumbnail** field to the media type's *Manage form
  display*, and usually pair it with **No thumbnail update** so a save doesn't
  overwrite the upload.

Click **Save configuration** to store your changes.

### 3. Refresh existing thumbnails

New thumbnails are generated as media is saved, but changing the width or adding a
generator does not retroactively rebuild anything. To regenerate everything, use the
**Refresh** tab (a confirm form that re-saves every media entity in a batch), or run
it from the command line:

```bash
drush thumbnails:refresh
```

Run a refresh after changing the width or background settings, after installing or
removing a generator plugin, or after migrating media files to a new file system.

### Notes

- Remote or oEmbed media (like remotely hosted video) is skipped automatically —
  only local file sources are processed.
- A generated thumbnail is never deleted while it's still referenced by more than
  one entity, and core's generic media icons are never removed.
- Generation failures are logged to the dedicated **media thumbnails** log channel,
  which is the place to look if a preview doesn't appear.
