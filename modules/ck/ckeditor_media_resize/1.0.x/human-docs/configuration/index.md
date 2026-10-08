# Configuration

There is no central settings page. You turn media resizing on **per text format**, and its
one option lives inside that format's CKEditor 5 settings. The setup has a few moving parts
that all have to line up, so follow the steps in order.

## What has to be in place

For the resize handles to appear, a text format needs all of the following:

- It uses **CKEditor 5**.
- The **Media** (`drupalMedia`) button is in the toolbar — the resize handles attach to the
  media widget, so media embedding must be available.
- Core's **Embed media** filter is enabled.
- Core's **Limit allowed HTML tags and correct faulty HTML** filter is enabled.
- This module's **Resize media images** filter is enabled — and it must run **before**
  *Embed media* in the filter order.

## Enable it on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a CKEditor 5 format — for example **Full
   HTML**.
2. In the CKEditor 5 toolbar builder, drag **Media** into the active toolbar if it is not
   already there.
3. Under **Enabled filters**, tick **Resize media images**. Make sure **Embed media** and
   **Limit allowed HTML tags and correct faulty HTML** are also ticked.
4. Under **Filter processing order**, drag **Resize media images** so it sits **above
   Embed media**. This ordering matters — if *Embed media* runs first, the media tag is
   already gone and nothing gets resized.
5. In the vertical tabs at the bottom of the page, open **Media image resize** and set the
   image-style option (below).
6. **Save configuration.**

## The one setting: "Media image resize"

On the **Media image resize** settings tab you get a single checkbox:

- **Enable this to dynamically scale resized images using image styles** *(on by default)* —
  when ticked, the module doesn't just apply a CSS width; it also picks a media view mode
  whose image style is the smallest one at least as wide as the requested width, so the
  browser downloads a right-sized derivative (e.g. a 300 px embed is served from the 500 px
  style). Untick it to apply only the inline CSS width and leave the original image in place.

The list of candidate image styles it chooses from (the four `cke_media_resize_*` styles
shipped with the module) is shown in the field description but is not editable from this
form — advanced users change it by editing the text format's editor configuration directly.

## Using it as an editor

Once a format is set up, embed a media image in the body as usual, then drag the corner
handle to resize it. Use the media toolbar's **Resize** option to return an image to its
original size. Resized embeds also get a `media-embed-resized` CSS class you can target in
your theme.

## Good to know

- If your format uses *Limit allowed HTML tags*, the module automatically allows the
  `data-media-width` attribute it needs on `<drupal-media>` while the plugin is enabled — you
  do not have to add it by hand.
- Inside CKEditor's own live preview the resize is left un-styled so the editor's drag
  handles keep working; the width is applied on the rendered page.
- The four shipped image styles scale to 200, 500, 800 and 1200 px (with upscaling), and the
  matching view modes were installed with the module.
