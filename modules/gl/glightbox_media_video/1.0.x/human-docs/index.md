# GLightbox Media Video — manual setup guide

**GLightbox Media Video** (`glightbox_media_video`) makes core Media **Video** (uploaded files)
and **Remote Video** (YouTube, Vimeo, and other oEmbed sources) open in a GLightbox popup
instead of playing inline. The base [GLightbox](https://www.drupal.org/project/glightbox)
module handles images; this add-on extends the same lightbox to the two core video media types,
launched from a thumbnail or a text link, with optional gallery grouping and captions.

It works by adding **two field formatters** you select on a media type's *Manage display*
screen. `glightbox_media_remote_video` formats the video-URL field on the *Remote Video* media
type (and, because it extends core's oEmbed formatter, keeps all of core's oEmbed settings).
`glightbox_file_video` formats the video-file field on the local *Video* media type. Both add
the same lightbox layer: a choice of thumbnail or text-link trigger, an image style for the
thumbnail, a **gallery grouping** option (so several videos share one lightbox carousel), and
caption / description options. The local-video formatter additionally lets you point at a custom
image field for the poster — the practical fix for uploaded videos having no automatic
thumbnail.

A couple of behaviours are worth knowing up front: YouTube URLs are automatically rewritten to
`youtube-nocookie.com` for a lighter privacy footprint, and other providers (Vimeo, etc.) open
whatever their oEmbed URL points at unless you alter it in code. The module requires core
**Media** and the contrib **GLightbox** module (which must have its JavaScript library
installed). It has **no config form, no permissions, and no config schema** — everything is
per-display formatter settings — so it does nothing until you switch a video field to one of its
formatters.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — every setting, the theme hooks, and the URL
alter quirk — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in GLightbox),
   enable it, and confirm the GLightbox JS library is present.

## How to use it

Formatters are set on the **media type's** display, not the host content type's:

1. **Remote video:** go to **Structure → Media types → Remote video → Manage display**, and for
   the **Video URL** field choose the format **GLightbox Media Remote Video**.
2. **Local video:** go to **Structure → Media types → Video → Manage display**, and for the
   **Video file** field choose the format **GLightbox Video Popup**.
3. Click the gear icon to set the options, then Save. Render your media reference on a node using
   a view mode that uses those displays.

Key options (shared by both formatters):

- **Display** — a thumbnail, a text link, or the media title as the clickable trigger.
- **Link text** — used when Display is a text link (default *View Video*).
- **Image style** — applied to the thumbnail.
- **Gallery (video grouping)** — which videos share one lightbox carousel. *Post* groups all
  videos on the same host entity; *page* groups everything on the rendered page; *custom* lets
  you supply a gallery id (token-aware when the Token module is enabled); and there are
  field/parent/paragraph-scoped options too.
- **Caption** and **Caption description** — the text shown in the lightbox, from the media name
  or a custom token string.

The **GLightbox Video Popup** (local video) formatter adds *Muted*, popup *Width* / *Height*,
and — importantly — a **custom thumbnail source field** (plus its image style) so local videos
get a real poster image. The **GLightbox Media Remote Video** formatter also keeps core's oEmbed
settings (max width/height, loading) alongside the lightbox options. The complete settings
tables and Drush examples are in [`agent/configure/formatters.md`](../agent/configure/formatters.md).

> **Caption or description, not both:** because of how the markup is built, setting both a
> caption *and* a description leaves only the description on the element. Choose one, or override
> the template if you truly need both (see the theming doc).

## Where it lives in the admin menu

There is no settings page. Everything is configured on a media type's **Manage display** screen
(under **Structure → Media types**) via the two formatters described above.
