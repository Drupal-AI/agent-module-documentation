# Configuration

Media Library Block has no global settings page — everything is configured **on the block
itself** when you place it. Each media type on your site has its own block (for example
"Image", "Remote video", "Document"), listed under the **Media** category.

## Place a media block

1. Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place block** in
   the region you want (or, in Layout Builder, **Add block** inside a section).
2. In the block chooser, find the **Media** category and pick the block named after the media
   type you want to feature — e.g. *Image* or *Remote video*.

## Block settings, field by field

When you place the block (or edit an existing placement), the configuration form shows:

- **Media** — a Media Library picker limited to this block's media type. Click it to browse,
  search, or upload, and select **one** item. (You can add new media inline here, thanks to the
  Media Library.) This field is required — the block needs an item to show.
- **View mode** — a select list of the view modes configured for this media type (for example
  *Default*, *Full*, *Thumbnail*, or any custom view mode). This decides how the selected media
  renders in the block. If left at the default, the block uses the media type's *Default* (or
  *Full*) view mode.

Below these you'll also find Drupal's standard block options — the admin **Title** and whether
to display it, plus region and visibility settings.

## Save

Click **Save block** (or **Add block** in Layout Builder). The chosen media renders in the
region using the selected view mode.

## Good to know

- **Access is respected.** If a visitor is not allowed to *view* the selected media item, the
  block simply renders nothing for them rather than leaking restricted content.
- **Different regions, different view modes.** Place the same media type block more than once —
  each placement has its own media item and view mode, so you can show one asset as a thumbnail
  in a sidebar and full‑size elsewhere.
- **Portable config.** Each placement records dependencies on the selected media item, its view
  display, and its media type, so the block exports and imports cleanly with your configuration.
