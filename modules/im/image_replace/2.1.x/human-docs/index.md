# Image Replace Effect — manual setup guide

**Image Replace Effect** (`image_replace`) adds an image style *effect* that
swaps the whole source image for a completely different one when a given image
style is rendered. It exists for "art direction": cases where a responsive
variant needs a different image, not just a crop or resize. A wide desktop banner
can become a portrait mobile image; a detailed logo can become a simplified glyph
at thumbnail sizes.

You set it up in two places. First you add the **Replace image** effect to an
image style — only styles that contain this effect can act as replacement
targets. Then, on any image field, an **Image replace** section lets you map each
replace-enabled style to another image field on the same content type (the
"source" field). When content is saved, the module records which replacement
image belongs to which style, and at the moment a derivative is generated the
effect substitutes the mapped image. If no replacement is mapped, the original
image is used unchanged.

Both the GD and ImageMagick toolkits are supported. There is no global settings
page, no permissions, and no Drush commands — everything is configured per image
style and per image field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. You work in two existing places:

- **Configuration → Media → Image styles**
  (`/admin/config/media/image-styles`) — to add the **Replace image** effect to a
  style.
- **Structure → (your content type) → Manage fields → (an image field) → Edit** —
  to map replacement source fields under the **Image replace** section.

## How to use it

### 1. Add the "Replace image" effect to a style

Go to **Configuration → Media → Image styles**, edit or create a style, and add
the effect **Replace image**. Only styles containing this effect become available
as replace targets. (You typically add it to the style you already use to render
the field — e.g. a "large" or "mobile" style.)

### 2. Add a second image field for the alternate image

On your content type, add a second image field to hold the alternate image — for
example a `field_mobile_image` alongside your main `field_hero`. Editors upload
the art-directed version there.

### 3. Map the source field on the main image field

Edit the **main** image field (Manage fields → the field → **Edit**). A collapsed
**Image replace** section lists one selector per replace-enabled style. For each
style, pick which *other* image field on the same content type should supply the
replacement. For example: when `field_hero` is rendered with the `large` style,
use the image from `field_mobile_image` (same position/delta) instead.

### 4. Save your content

The replacement mapping is built when an entity is **saved**, not when you change
the field settings. So after you first set up (or later change) a mapping, you
must **re-save existing content** for it to take effect. On sites with lots of
content, use the admin content list's bulk operations (or a "save" VBO action) to
re-save in bulk. The field settings form warns you about this.

One more caveat the module warns about: browsers, CDNs, and other HTTP caches may
still hold the old derivative. Re-saving rebuilds the mapping and flushes Drupal's
own derivatives, but on a live site the only fully reliable cache-bust is to
re-upload the image under a new filename.

### Notes

- Requires core **Image**. The ImageMagick replace operation additionally needs
  the `drupal/imagemagick` module.
- A field can map several styles at once, each pulling from its own source field.
- For developers: the `image_replace.storage` service exposes `get()`, `add()`,
  and `remove()` for querying and editing the replacement lookup table
  programmatically — see the [`agent/`](../agent/start.md) docs.
