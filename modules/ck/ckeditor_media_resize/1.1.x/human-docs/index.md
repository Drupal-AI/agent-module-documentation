# CKEditor5 Media Resize — manual setup guide

**CKEditor5 Media Resize** (`ckeditor_media_resize`) fills a gap in Drupal core:
core's CKEditor 5 lets editors drag-resize images they upload directly, but images
embedded through the **media library** (`<drupal-media>` embeds) cannot be resized.
This module adds exactly that missing ability — editors drag the corners of an
embedded media image and the chosen width is remembered.

Under the hood it stores the chosen width on the embed as a `data-media-width`
attribute, and a text filter turns that into an inline `width:` style when the page
renders. Optionally, it can also swap in a matching **image style** so the browser
downloads a correctly-sized derivative instead of shipping a full-resolution
original for a small inline image — good for page weight.

The module does not work entirely on enable: after installing it you must turn it
on for each **text format** where you want media resizing, by adding a filter and a
toolbar button and getting the filter order right. It depends on core's
**CKEditor 5**, **Image**, and **Media Library** modules. There are no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no module settings page** for CKEditor5 Media Resize — all of its
configuration lives on the individual **text format** you enable it for, described
in "How to set it up on a text format" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You configure it entirely from
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), by editing the text format(s) you want media
resizing on.

## How to set it up on a text format

After enabling the module, do the following for each text format that uses CKEditor 5
and media embeds:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on your format (for
   example *Full HTML*).
2. In the CKEditor 5 toolbar configuration, drag the **Media embed** button from the
   available buttons into the active toolbar (if it isn't already there).
3. Under **Enabled filters**, tick these three:
   - **Limit allowed HTML tags and correct faulty HTML**
   - **Resize media images** (this module's filter)
   - **Embed media**
4. Set the **filter processing order** so that **Resize media images** runs *before*
   **Embed media**. This ordering is required — if the resize filter runs after the
   embed filter, the stored width is lost.
5. Configure the **Embed media** filter to allow at least the **Image** media
   bundle. Only image media can be resized; other media bundles are not supported.
6. Save the text format.

Editors using that format can now select an embedded image in CKEditor 5 and drag
its corner handles to resize it, or use the resize toolbar item to return it to its
original size.

## About image styles

The module ships four image styles — `cke_media_resize_small` (200px),
`_medium` (500px), `_large` (800px), and `_xl` (1200px) — plus matching media view
modes. By default ("Apply image styles" is on) it picks the smallest of these whose
width is at least the width the editor requested, so a small inline embed serves a
small derivative. If you would rather keep only the CSS width and always serve the
original, that behavior is controlled by the `apply_image_styles` option on the
CKEditor plugin configuration for the format. You can also point it at your own
image styles instead of the shipped ones.
