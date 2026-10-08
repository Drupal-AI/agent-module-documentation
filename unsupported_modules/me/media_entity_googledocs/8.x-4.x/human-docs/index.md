# Media entity GoogleDocs — manual setup guide

**Media entity GoogleDocs** (`media_entity_googledocs`) adds a media source so
that published Google Docs, Sheets, Slides, and Forms — either their
published‑embed URLs or the full `<iframe>` embed codes Google gives you — can be
stored as Drupal media entities and rendered inline. Once a document is added, it
lives in the media library and can be reused across the site through media
reference fields, just like an image or a video.

Setting it up means creating a media type that uses the GoogleDocs source. Editors
then paste a published Google embed URL (or the whole iframe snippet) and the
module recognises it: it validates the value against the shape of a genuine Google
published‑embed URL, works out whether it is a document, spreadsheet,
presentation, or form, and shows a matching thumbnail icon. A field formatter
renders the document as an `<iframe>` with configurable width, height, scrolling,
and fullscreen.

One reassuring point about how it works: the module never fetches the Google URL
from your server — it only pattern‑matches the pasted value and then emits an
`<iframe>` for the visitor's browser to load. So there is no server‑side request
to worry about; the residual consideration is ordinary embed trust and privacy,
since the document loads from Google in the visitor's browser.

A compatibility note before you deploy: this branch targets **Drupal 8 and 9**
(`^8 || ^9`), so confirm it fits your core version before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media module.

This module has no separate settings page. You set it up by creating a media type
that uses the GoogleDocs source and choosing its display formatter, described
below.

## Where it lives in the admin menu

Media entity GoogleDocs adds no admin settings form. The media types you create
with the GoogleDocs source appear under **Structure → Media types**
(`/admin/structure/media`), and individual documents are managed from **Content →
Media** (`/admin/content/media`) or through the Media Library.

## How to use it

1. **Create a media type that uses the GoogleDocs source.** Go to **Structure →
   Media types → Add media type** (`/admin/structure/media/add`), name it (for
   example "Google document"), and in the **Media source** field choose
   **GoogleDocs**. For the source field, a `link`, `string`, or `string_long`
   field all work. Save.
2. **Set the display formatter.** On the media type's **Manage display** tab, set
   the source field's **Format** to **GoogleDocs embed generic**. Use its settings
   gear to set the iframe **width** (default 480) and **height** (default 299) and
   to toggle **scrolling** and **fullscreen**. Save.
3. **Add a document.** Go to **Content → Media → Add media**, choose your
   GoogleDocs media type, and paste either a **published** Google embed URL or the
   full `<iframe>` embed code. If the value isn't a recognised Google
   published‑embed URL, validation rejects it. Save.
4. **Reuse it.** The document is now in the Media Library and can be referenced
   from media reference fields across the site.

> **Tip:** the source must be a *published* embed — in Google, use **File →
> Share → Publish to the web** (or the equivalent "embed" option) and copy the
> URL or iframe it gives you, rather than the ordinary sharing link.
