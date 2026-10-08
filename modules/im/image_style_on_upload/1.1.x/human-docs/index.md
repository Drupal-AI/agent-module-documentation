# Image Style On Upload — manual setup guide

**Image Style On Upload** (`image_style_on_upload`) permanently applies a chosen
image style to image files **as they are uploaded**, replacing the stored original
with the processed version. It is most commonly used to cap the dimensions of
uploaded images — for example scaling everything down to a maximum width — so that
oversized originals (like multi-megapixel phone photos) never hit disk at full size.

This is different from how Drupal image styles normally work. Core keeps the original
file and generates derivatives on demand when they are displayed. This module instead
rewrites the source file itself at upload time, so the stored file *is* the styled
version. That saves storage and bandwidth and reduces later derivative-generation
cost — but it is **destructive to the original**, so choose your style with that in
mind.

Out of the box the module ships an optional **"upload"** image style that scales
images to 2000px wide (without upscaling), and it only processes JPEG, PNG, and GIF
files by default. Both the style it applies and the list of image types it acts on
are configurable. The module has no dependencies beyond Drupal core, no permissions
of its own, and no Drush commands.

This guide is written for a **human**. If you want terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Image Style On Upload**
(`/admin/config/media/image_style_on_upload`), reachable by anyone with the
*Administer site configuration* permission.

## How to use it

Once the module is enabled, uploaded images are processed automatically — you only
need to confirm which style is applied and to which file types:

1. Go to **Configuration → Media → Image Style On Upload**.
2. **Image style** — choose the image style to apply to each qualifying upload. The
   default is the shipped **upload** style (scale to 2000px wide). Choose
   *- No image style -* to switch processing off. Any existing image style (crop,
   scale, resize…) can be used.
3. **MIME types** — a space-separated whitelist of image types to process. The
   default is `image/gif image/jpeg image/png`. Add another type (for example
   `image/webp`) to include it, or remove one to skip it.
4. Save. From now on, any image whose type is in the whitelist is run through the
   chosen style and stored in its processed form when uploaded through any file or
   image field.

Because the original file is replaced, this happens once, at upload — there is no way
to recover the pre-processing original afterwards, so pick a style that keeps enough
quality and size for your needs.
