# Configuration

There are two things to configure: a **display** (either the field formatter or
the Views style) that decides *what* becomes a gallery and how it looks, and the
optional **global settings** that apply site-wide.

## Option A — the field formatter

Use this to turn an image, file, or media-reference field on an entity into a
gallery.

1. Add a multi-value **image** (or file, or media reference) field to a content
   type if you don't have one.
2. Go to that entity's **Manage display** screen, e.g. **Structure → Content
   types → Article → Manage display**.
3. Set your field's **Format** to **Juicebox Gallery**.
4. Click the gear/settings icon and configure:
   - **Main image style** — the image style used for the large images (choose one
     of the bundled `juicebox_*` styles, your own, or "original").
   - **Thumbnail image style** — the style used for the thumbnail strip
     (`juicebox_square_thumb` gives a uniform grid regardless of source aspect
     ratio).
   - **Caption source** and **Title source** — where each slide's caption and
     title come from: the image alt text, the image title, the filename, or the
     file description.
   - **Common Juicebox options** — gallery width and height (a fixed size or 100%
     responsive), background/text/thumb-frame colors, which buttons show, and how
     each slide links out (e.g. to the original image, opening in a new tab).
   - **Incompatible file action** — how non-image files (PDFs and the like) mixed
     into a file field are handled: skip them, or show an icon and link.
   - **Manual configuration** — a textarea to paste raw Juicebox name/value config
     pairs for advanced or Pro-only options not exposed as fields.
5. Save.

## Option B — the Views style

Use this to render a whole View's rows as one gallery.

1. Edit a View that lists images (or entities with image fields).
2. In **Format**, choose **Juicebox Gallery**.
3. In the style settings, map the fields that supply the gallery: the **image
   field** and its style, the **thumbnail field** and its style, and the **title**
   and **caption** fields. The same common Juicebox options (dimensions, colors,
   buttons, link behaviour) are available here too.
4. Save.

## Global settings

The site-wide settings form is at **Configuration → Media → Juicebox**
(`/admin/config/media/juicebox`), gated by the core **Administer site
configuration** permission. The options are:

- **Apply markup filter** *(on by default)* — filter title/caption output for
  compatibility with the Juicebox JavaScript.
- **Enable CORS** *(off by default)* — allow a gallery's XML/embed to be pulled
  into a remote site.
- **Translate interface** *(off by default)* — translate the Juicebox interface
  strings, with a **Base language list** string to seed the translation.
- **Multi-size image styles** — the image styles mapped to Juicebox's "small",
  "medium", and "large" multi-size modes (defaults: `juicebox_small`,
  `juicebox_medium`, `juicebox_large`).

You can also set these with Drush, for example:

```bash
drush config:set juicebox.settings enable_cors true -y
```

## Bundled image styles

Enabling the module installs four image styles you can use anywhere a style is
selected: `juicebox_small`, `juicebox_medium`, `juicebox_large`, and
`juicebox_square_thumb`. You're free to use your own styles instead.

## Reminder: the JavaScript library

The formatter and Views style save fine, and the gallery's XML feed is emitted,
even without the Juicebox JavaScript library — but a gallery only *renders* in the
browser once `juicebox.js` is present under `/libraries/juicebox/`. See
[Installation](../installation/index.md#add-the-juicebox-javascript-library-required-for-a-live-gallery).
