# Configuration

All configuration happens on the **text format** where you want galleries — there
is no separate settings page. You add the toolbar button, enable a filter, and
then tune how galleries look and where captions come from.

## Add the button and enable the filter

1. Log in as a user with the **Administer filters** permission (an administrator
   by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Edit the text format you want galleries in — it must use **CKEditor 5** as its
   editor.
4. In the CKEditor 5 toolbar configuration, drag the **Image gallery** button into
   the active toolbar.
5. On the same format's **Filters** list, enable the **Embed image galleries**
   filter.
6. Click **Save configuration**.

## Review the gallery filter settings

Expand the settings for the **Embed image galleries** filter to tune how galleries
behave. The available options include:

- **Allowed media types** — which media bundles editors may pick from (for
  example, restrict to your *Image* media type).
- **Default gallery type** — which of the four display types (large image with
  thumbnail strip, masonry grid, carousel, uniform grid) new galleries start
  with. Editors can still switch per gallery from the widget toolbar.
- **Image styles (or responsive image styles)** — separate choices for the
  thumbnails, the grid images, and the lightbox images. Responsive image style
  options appear only if core Responsive Image is enabled.
- **Media view mode for the large image** — the view mode used to render the main
  "stage" image.
- **Lightbox behavior** — settings governing the fullscreen GLightbox view.
- **Caption and copyright fields** — which media fields supply the caption and
  copyright text shown in the lightbox. The defaults are `field_caption` and
  `field_copyright`; change these to match the fields on your media types.

## Save

Click **Save configuration**. The button and gallery behavior take effect
immediately for any field using that format.

## Using it after configuration

No new content types, entities, or permissions are created — galleries live inside
the text. When editing content, click the **Image gallery** button, select images
in the Media Library, and the gallery appears in the editor. Select the widget to
switch its display type, reorder or remove images, or add more. Captions and
copyright stay hidden inline and appear only in the fullscreen lightbox, keeping
the article clean while preserving attribution.
