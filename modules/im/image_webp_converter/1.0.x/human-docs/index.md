# Image WebP Converter — manual setup guide

**Image WebP Converter** (`image_webp_converter`) converts the images already
uploaded to your site into the **WebP** format and rewrites the stored filenames
and the references that point at them. WebP is typically 25–35% smaller than an
equivalent JPEG at the same visual quality, and since images make up the bulk of
most pages' weight, converting an existing library is one of the larger
performance wins available without redesigning anything.

It can convert automatically on upload, convert content site‑wide in batches, and
optionally let editors decide per node. It also converts inline images embedded
in CKEditor fields. Under the hood it supports three conversion tools — **cwebp**
(a command‑line binary), **Imagick**, and **GD** — so you can pick whichever your
server supports. It relies on the `rosell-dk/webp-convert` PHP library, which is
usually installed with the module.

> **Know the alternative first.** Drupal can already produce WebP **derivatives**
> through image styles — that covers rendered images, leaves your originals
> untouched, and is the right approach for most sites. **This module converts the
> source files instead**, which reduces stored size as well as delivered size — but
> **is not reversible**. Plan carefully:
>
> 1. **It edits content.** Rewriting references means writing to your entities —
>    **take a database backup and run it on a copy first.** A missed reference
>    becomes a broken image; a wrongly rewritten one becomes a wrong image.
> 2. **Originals are the archive.** An uploaded photograph is often the only copy
>    the organisation has — converting rather than deriving discards the original
>    permanently. Decide per field, not blindly site‑wide.
> 3. **Externally held URLs don't update.** Anything linking directly to an image
>    file — an email, a PDF, another site, a search index — will point at a
>    filename that no longer exists.

The module requires core's **File** and **Image** modules, provides a
`convert images to webp` permission plus a restricted administrative one, and
supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required library) and enable it.
2. [Configuration](configuration/index.md) — choose a converter, set quality, and
   run a site‑wide conversion.

## Where it lives in the admin menu

The settings and site‑wide conversion tool are at **Configuration → Media → Image
WebP Converter Settings** (`/admin/config/media/image-webp-converter`).

## How to use it

1. Install the module **and** the `rosell-dk/webp-convert` library, then enable it
   (see [Installation](installation/index.md)).
2. If your file or image fields don't already allow the `.webp` extension, add it
   under **Structure → Content types → *(type)* → Manage fields**, editing the
   field and adding `webp` to the allowed extensions.
3. Configure the converter, quality, and options (see
   [Configuration](configuration/index.md)).
4. **Back up your database**, then run a site‑wide conversion from the settings
   page, or let new uploads convert automatically.
