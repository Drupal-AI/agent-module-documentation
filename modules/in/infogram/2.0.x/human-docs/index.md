# Infogram graphs — manual setup guide

**Infogram graphs** (`infogram`) embeds interactive charts and infographics from
[Infogram](https://infogram.com) into your Drupal content. It gives you two ways
to place an Infogram embed, so it fits both structured media workflows and
free-form authoring:

- as a **media oEmbed source**, so an `infogram.com/*` share URL becomes a proper
  media entity you can add through the media library and reuse; and
- as a **WYSIWYG text-format filter**, so authors can paste Infogram's WordPress-
  style shortcode directly into a rich-text field and have it render inline.

Under the hood the module registers Infogram as an oEmbed media source and renders
embeds through a small Twig template plus Infogram's own embed-loader script. The
shortcode values are output into quoted, auto-escaped `data-` attributes, so the
markup stays clean and safe.

Two things are worth knowing up front. First, this is an **embedding** feature:
the rendered chart is loaded from Infogram's servers at view time, so visitors'
browsers contact a third party — keep that in mind for privacy and consent. Grant
the text-format filter only to trusted roles, as with any embed filter. Second,
full thumbnail generation for media relies on a Drupal core patch (see the
[project page](https://www.drupal.org/project/infogram) and issue
[#3042423](https://www.drupal.org/project/drupal/issues/3042423)); the embeds
themselves work without it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module. Setup happens by enabling
the embed filter on a text format and/or using the media library — see "How to use
it" below.

## Where it lives in the admin menu

Infogram adds no configuration page of its own. You turn on its **filter** at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and you add Infogram **media** at
**Content → Media → Add media** (`/media/add/infogram`) or through the media
library.

## How to use it

**Via the WYSIWYG filter**

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the text format your authors use
   (`/admin/config/content/formats/manage/{format}`).
2. Enable the **Infogram embed codes** filter and save.
3. In content using that format, paste the WordPress code from your Infogram
   account, for example:

   ```text
   [infogram id="{id}" format="{format}" prefix="ignored" title="ignored"]
   ```

   The Infogram graph renders in place of the shortcode.

**Via the media library**

1. Go to `/media/add/infogram`, or open the media library and choose the Infogram
   type.
2. Copy any `infogram.com` URL from the chart's **Share** tab and paste it in.
3. Save — the Infogram media is now ready to reference from media fields or insert
   through the editor's media button.
