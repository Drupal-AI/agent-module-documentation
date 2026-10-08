# ImageLightbox — manual setup guide

**ImageLightbox** (`imagelightbox`) displays your image and media fields as
clickable thumbnails that open the full picture in a responsive, touch-friendly
lightbox overlay. All the images in a field are grouped into one swipeable
gallery, so visitors can page through them with arrows, the keyboard, or swipe
gestures on a phone. It's a lightweight alternative to heavier lightbox modules —
the [imageLightbox.js](https://osvaldas.info/image-lightbox-responsive-touch-friendly)
library is bundled right inside the module, so there's nothing to download and no
CDN to rely on.

You use it by choosing one of its two **field formatters** on an entity's *Manage
display* tab. The `imagelightbox` formatter is for core **Image** fields; the
`mediaimagelightbox` formatter is for **Media reference** fields that point at
image media. Each formatter has its own settings: a thumbnail image style for the
trigger, a larger image style for the lightbox view, an optional caption sourced
from the image title or alt text, and toggles for inline layout, a light theme, a
navigation bar, and a loading spinner.

There is **no global settings page** and no permissions — everything is
configured per display. Themers can override the trigger markup and the
JavaScript init options from a custom theme if they need finer control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. All configuration happens on each entity's
**Manage display** tab (for example
`/admin/structure/types/manage/article/display`), where you pick an ImageLightbox
formatter for an image or media field.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** tab of the content type (or other entity) that
   has your image or media field.
3. In the field's **Format** dropdown choose:
   - **ImageLightbox** (`imagelightbox`) for a core **Image** field, or
   - **Media ImageLightbox** (`mediaimagelightbox`) for an **entity reference**
     field pointing at image **Media** (it reads the referenced media's image).
4. Click the cog to set the options:
   - **Thumbnail image style** — the style used for the clickable trigger
     (default *thumbnail*). Choose "None" to use the original image.
   - **Lightbox image style** — the style used for the full image shown in the
     overlay (default *large*). "None" serves the original.
   - **Caption source** — where the lightbox caption comes from: the image
     **title**, the image **alt** text, or **None**.
   - **Inline** — lay the thumbnails out side by side (adds `container-inline`).
   - **Light theme** — use the light lightbox chrome instead of the dark overlay.
   - **Navigation bar** — show a thumbnail strip under the lightbox image.
   - **Activity/loading spinner** — show a spinner while the next image loads.
5. Save. The field now renders as a gallery — clicking any thumbnail opens the
   lightbox, and all images in the field page through together (arrows,
   keyboard, and swipe are enabled automatically).

### Using it inside a View

When you place the field in a **View**, enable **"Use field template"** on the
field (or add the `imagelightbox` class in the field's style settings) so the
grouped gallery links are emitted correctly.

### Customizing from a theme (optional)

Advanced users can override the JavaScript init options (animation speed, arrows,
fullscreen, and so on) by copying the module's `imagelightbox.config.js` into a
custom theme and pointing at it with a `libraries-override` entry in the theme's
`.info.yml`. You can also override the `imagelightbox-formatter.html.twig`
template to wrap the trigger in custom markup.

A note on captions: they come from the image's title/alt text and are rendered
into an HTML attribute that Drupal escapes automatically, so keep those caption
sources as plain author-controlled text.
