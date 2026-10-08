# AI Alt Text Generator for Images (AutoAlt.ai) — manual setup guide

**AI Alt Text Generator for Images — AutoAlt.ai** (`autoalt`) generates alt text
for your images by sending them to the **AutoAlt.ai** service and writing the
returned description back to your image and media fields. It supports both a
single-image workflow and a bulk run that can process many images at once — handy
for accessibility and SEO on sites with large image libraries.

You authenticate with an AutoAlt.ai **API key** entered on the module's settings
form. From there, a bulk UI lets you generate alt text for images across the
site, filter by language, skip images already processed, target images with
short or missing alt text, and see how many AutoAlt credits you have left. A
history page records what has been processed.

**Where your images go.** To generate alt text, the module reads an image file,
encodes it, and sends it — together with your stored API key — to the AutoAlt.ai
service over HTTPS. So your image content leaves your site for processing, and
usage draws down the credits tied to your API key.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your AutoAlt.ai API key and
   the generation settings.

## Where it lives in the admin menu

- **Settings / API key:** Configuration → Content authoring → AutoAlt
  (`/admin/config/content/autoalt`), protected by **Administer site
  configuration**.
- **Bulk alt text:** `/admin/config/media/autoalt/bulk-alt`.
- **Processing history:** `/admin/content/autoalt/history`.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter your AutoAlt.ai API key and settings (see
   [Configuration](configuration/index.md)).
3. Generate alt text for a single uploaded image, or open the bulk screen at
   `/admin/config/media/autoalt/bulk-alt` to process many images — filtering by
   language, skipping already-processed images, and targeting short/missing alt
   text. Generated text is saved back to your image and media fields, and you can
   review what ran on the history page.
