# Media Remote Image — manual setup guide

**Media Remote Image** (`media_entity_remote_image`) adds a media source for
images that live somewhere else. Instead of uploading a file, you store a **URL**
(or an internal path), and the media entity references the remote asset — so the
image participates fully in Drupal's media system (searchable in the library,
referenced from fields, usable in a WYSIWYG, subject to media access) while the
bytes stay where they are. It ships a ready‑to‑use **Remote image** media type,
depends on core's Link and Media modules, and runs across Drupal 8 through 11.

Not every image should be uploaded. A digital asset management system may be the
authoritative home for an organisation's photography; a partner might supply
imagery on their own CDN under their own licence; a product catalogue's photos
might be owned by the supplier's system. In each case re‑uploading into Drupal
creates a second copy that immediately starts to drift, and this module lets you
avoid that. It supports common formats (JPEG, PNG, GIF, SVG, TIFF, WebP, AVIF),
ALT text, multiple images per entity, formatter settings for maximum display width
and height, lazy/eager loading and linking, and it can optionally generate local
thumbnail previews for the media admin and Media Library.

Two trade‑offs are worth naming honestly, because they are more than they first
appear. **Image styles need the file:** because the original isn't copied locally,
core image styles, responsive images, and cropping either don't apply to the full
remote image or would require fetching it anyway. (If you need styles on the
original, the project suggests
[Remote Stream Wrapper](https://www.drupal.org/project/remote_stream_wrapper),
which copies remote files in.) And **availability is someone else's:** a broken
remote URL is a broken image on your page with no local fallback, and it fails
silently until someone notices. There is also a legal dimension — many image hosts
forbid hotlinking or require attribution, so make sure you have the rights to
embed the images you reference.

> **A note for site builders on server‑side fetching.** When media is saved the
> site contacts the remote URL from the server to confirm it returns an image, and
> — if you turn on local thumbnails — to download the preview. That means the
> remote host must be reachable from your web server, and creating remote‑image
> media should be restricted to trusted editors, as it is for any media type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media and Link modules.
2. [Configuration](configuration/index.md) — the module's settings form (notably
   the local‑thumbnail option) and how to use the Remote image media type.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Media → Media Remote Image
settings** (`/admin/config/media/media-entity-remote-image-settings`), behind the
**Administer site configuration** permission. The **Remote image** media type it
provides appears under **Structure → Media types** (`/admin/structure/media`), and
individual images are managed from **Content → Media**
(`/admin/content/media`) or through the Media Library.

## How to use it

1. After enabling the module you can use the included **Remote image** media type
   straight away, or create an additional media type using the **Remote image**
   media source under **Structure → Media types → Add media type**.
2. Go to **Content → Media → Add media → Remote image**, paste an external image
   URL (or internal path), add ALT text, and save. A saved item shows a preview of
   the remote image on its edit form.
3. Reference the media anywhere media is supported — media reference fields, Views,
   the Media Library, and CKEditor.

See [Configuration](configuration/index.md) for the thumbnail‑preview option and
for enabling a manual Name field on the media type.
