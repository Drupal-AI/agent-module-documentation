# Media Download — manual setup guide

**Media Download** (`media_download`) turns a media entity's canonical page —
`/media/{id}` — into a **direct download** of the media's source file, instead of
a rendered entity page. Link to that URL and the browser gets the actual PDF,
document, image, audio or video file, not a themed "media view" page.

By default the file is served **inline** (so PDFs and images open in the browser).
Append `?dl=1` to the URL — `/media/{id}?dl=1` — and the response switches to a
forced "Save as" download, which is perfect for a "Download" button. The correct
`Content-Type` comes from the file entity, and `ETag`/`Last-Modified` headers are
set automatically so clients can cache efficiently.

The module takes care of the details that make this safe and reliable: it forces
core's "standalone media URL" setting on at runtime (so `/media/{id}` always
works while the module is installed), it never lets these binary responses get
page‑cached, and it serves files with a `Content-Security-Policy: sandbox` header
to neutralise SVG‑based cross‑site‑scripting. Access is still governed by the
normal **view media** permission, so private or unpublished media stay protected.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent — including the exact route override and response behavior
— read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Media Download has **no settings page, no permissions and no admin links of its
own** (`configure: null`). Enabling it simply changes what the `/media/{id}` URL
does. One thing you will notice: the core **media settings** page
(`/admin/config/media/media-settings`) shows a warning that the "standalone media
URL" toggle has no effect while this module is installed — because the module
forces it on.

## How to use it

There is nothing to configure — enable the module and the behavior is active:

- **`/media/{id}`** — serves the media's source file inline (browser displays
  PDFs, images, etc.).
- **`/media/{id}?dl=1`** — forces a "Save as" download of the same file.

Common ways to use it:

- Give editors a clean, shareable link straight to an uploaded asset.
- Add a **Download** button that points at `/media/{id}?dl=1`.
- Build a "download center" page linking to each asset's canonical URL.
- Let a Views "media name" link resolve to the file itself rather than an entity
  page.

For media that references multiple files, the first valid file that exists on
disk in the source field is served.
