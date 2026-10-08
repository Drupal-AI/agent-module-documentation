# Media Embed Extra — manual setup guide

**Media Embed Extra** (`media_embed_extra`) adds per-embed **Width** and
**Height** override fields to Drupal core's media embed dialog, so an editor can
resize an individual embedded image straight from the WYSIWYG editor — without
changing the source media item or creating extra image styles.

It's a thin, focused enhancement of core Media's embedding. When an editor
double-clicks an embedded **image** in CKEditor, the "Edit media" dialog gains a
**Dimensions** fieldset with Width and Height number fields. The chosen values
are stored as `data-width` and `data-height` attributes on the `<drupal-media>`
tag, and the module reads them back at render time to override the displayed
image's dimensions. Enter only one dimension and the other scales proportionally
from the image's aspect ratio. The underlying media entity is never modified —
only the rendered size for that particular placement changes, so you can reuse
one high-resolution media item at different sizes on different pages.

The Dimensions fields appear **only for image-source media**; other media types
(with no image field) are left completely alone. There is no settings page, no
permission, and no Drush command — the module works by quietly enhancing core's
existing **Embed media** filter. That means the only setup is making sure the
text format your editors use has media embedding turned on (and, if you limit
allowed HTML, that the new attributes are permitted).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Media Embed Extra has **no configuration page of its own**. The one thing you may
need to touch is your text formats, at **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`).

## How to use it

The module works automatically once the text format your editors use is set up
for media embedding. To confirm (or enable) that:

1. Go to **Configuration → Content authoring → Text formats and editors** and
   edit the format your editors use (for example **Full HTML**).
2. Under **Enabled filters**, make sure **Embed media** is ticked. Media Embed
   Extra hooks into this core filter, so its dimension handling only runs when
   Embed media is on.
3. If **Limit allowed HTML tags and correct faulty HTML** is enabled for that
   format, add `data-width` and `data-height` to the `<drupal-media …>` entry in
   the **Allowed HTML tags** box — otherwise Drupal strips those attributes
   before the image renders. A complete entry looks like:

   ```
   <drupal-media data-entity-type data-entity-uuid data-view-mode data-align data-caption data-width data-height>
   ```
4. Save the format.

Now, when an editor embeds or edits an **image** media item in the editor and
opens its "Edit media" dialog, a **Dimensions** fieldset with **Width** and
**Height** fields appears. Filling in one or both resizes that single embed;
leaving one blank lets it scale proportionally. Because the module reuses core's
filter pipeline, it plays nicely with the Align and Caption features for sized,
captioned embeds.
