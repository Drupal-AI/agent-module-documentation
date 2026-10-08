# Media Image Style Formatter — manual setup guide

**Media Image Style Formatter** (`media_image_style_formatter`) lets you render a
media (image) reference through a chosen **image style** — or as the original,
uncropped image — directly from the field formatter settings, without creating an
extra view mode on the media entity for every size you need.

It works by extending Drupal core's existing **"Rendered entity"** formatter rather
than adding a formatter of its own. When you select *Rendered entity* for a media
field that references Image media bundles, new override options appear
automatically: you tick **Override entity image style**, pick which image field
inside the media to target (defaults to `field_media_image`, but custom fields are
supported), and choose an image style — or **"None (original image)"** to show the
full‑size original. Everything else about the rendered media (captions, alt/title
text, links, other fields) is preserved; only the image style is overridden, and
cache handling is done properly so variations cache reliably.

This solves the classic core annoyance where you had to create a separate view mode
on the Image media bundle for every different size — leading to view‑mode bloat.
With this module you can show the same reusable media as a small thumbnail in
teasers and a larger version on full pages, using the same media view mode, and it
works identically on entity **Manage display** pages and in **Views** field
configurations.

This is a content‑display feature only. Rendered images follow core media and image
access, so the module plays no part in access control, and it works only with Image
media types.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no global settings page** and no new formatter to choose — the module
enhances the core *Rendered entity* formatter automatically. All configuration
happens in that formatter's settings, described below.

## Where it lives in the admin menu

The module adds no admin page and no content types. You use it entirely from
**Manage display** (and Views field settings) on media reference fields limited to
Image bundles. Image styles themselves live at **Configuration → Media → Image
styles** (`/admin/config/media/image-styles`).

## How to use it

1. Go to a bundle's **Manage display** (a content type, paragraph, block type,
   etc.) that has a media reference field limited to Image bundles.
2. Set that field's format to **Rendered entity** (no change needed if it's already
   selected — it's now powered by this module).
3. Open the gear settings and enable **Override entity image style**.
4. Choose the target image field (usually `field_media_image`) and pick an **image
   style**, or **None (original image)** for the full‑size original.
5. **Save**. The override applies only to this specific display context. The same
   options also appear when configuring media fields in **Views**.

> **Tip:** If the override options don't appear immediately after install, clear
> caches. And if you don't yet have the image style you want, create it first at
> **Configuration → Media → Image styles**.
