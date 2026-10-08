# Magnific Popup — manual setup guide

**Magnific Popup** (`magnific_popup`) adds a field formatter that turns image
fields (and, optionally, Video Embed Field fields) into clickable thumbnails that
open the full-size image or video in a Magnific Popup lightbox. There is no admin
settings page and nothing to configure globally — you simply pick the *Magnific
Popup* formatter on a field's *Manage display* screen, and editors get a
zero-effort lightbox with no JavaScript to write.

The image formatter can group multiple images into a gallery the visitor can page
through, show only the first thumbnail while still gallerying the rest, or render
each image as its own independent popup. You can also choose which image style to
use for the small thumbnail versus the large popup image, and how tall images
should fit. If the **Video Embed Field** contrib module is installed, a second
formatter lets embedded YouTube/Vimeo videos open in the same lightbox.

Magnific Popup wraps a third-party JavaScript/CSS library, so that library must be
present under `web/libraries/magnific-popup` for the popup to actually initialize
in the browser — see [Installation](installation/index.md). The module works on
Drupal 10.3+ and 11, has no other Drupal module dependencies, and defines no
permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   JavaScript library, and enable it.

(There is no separate configuration page — the module has no settings form. You
configure it per field on *Manage display*, described below.)

## Where it lives in the admin menu

There is no admin page. You enable the lightbox on a field at **Structure →
Content types → [your type] → Manage display**
(`/admin/structure/types/manage/<type>/display`), or the equivalent *Manage
display* screen for any entity type that has an image or video field.

## How to use it

1. Make sure the Magnific Popup library is installed (see
   [Installation](installation/index.md)).
2. Go to the *Manage display* screen of the content type (or other entity) whose
   image field you want to make a lightbox, for a given view mode (e.g. *Default*
   or *Teaser*).
3. In the **Format** column for your image field, choose **Magnific Popup**.
4. Click the settings cog to configure the formatter:
   - **Thumbnail image style** — the image style used for the clickable
     thumbnail. Leave empty to use the original image.
   - **Popup image style** — the image style used for the large image shown in
     the lightbox. Leave empty to serve the original image.
   - **Gallery type** — *All items* groups every thumbnail into one gallery the
     visitor can page through; *First item* shows only the first thumbnail but
     still galleries all images in the popup; *Separate items* makes each image
     its own independent popup with no gallery grouping.
   - **Vertical fit** — fit tall images vertically (the default) or horizontally.
5. Click **Update**, then **Save**.

Because these settings live on the entity's view display, they are exported as
part of your `core.entity_view_display.*` configuration and can differ per view
mode (for example, a lightbox on full view but not on teaser). For a Video Embed
Field, pick the **Magnific Popup** formatter on that field instead (available only
when Video Embed Field is installed).
