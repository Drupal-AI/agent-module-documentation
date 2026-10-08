# Configuration

PhotoSwipe has two levels of configuration: **per‑field formatter settings** (how a
given field's images look and which styles they use) and a **global settings form**
(how the lightbox behaves site‑wide).

## Apply a formatter to a field

1. Go to the display you want — for example **Structure → Content types →
   *Article* → Manage display** (`/admin/structure/types/manage/article/display`).
   Any entity's Manage display works, and you can also use the formatter on an
   image/media field in a View.
2. For your image field (or a media / entity‑reference field), open the **Format**
   dropdown and choose **Photoswipe** or **Photoswipe Responsive**.
3. Click the **gear icon** to open the formatter's settings.
4. Set the options below, click **Update**, then **Save**.

### Formatter settings, field by field

| Setting | What it does |
|---|---|
| **Thumbnail image style** | The image style used for the thumbnail shown on the page (the one visitors click). Leave as *Original* for the full image. There is also a special **Hide** option that builds the gallery without showing an on‑page image at all. |
| **Override first image thumbnail style** | An optional different style for just the first image — handy if you want the lead image larger than the rest. Leave empty for no override. |
| **Photoswipe modal image style** | The image style used for the large image shown *inside* the lightbox. Choose a resized style here to serve something lighter than the original. |
| **Image field of the referenced entity** | Only relevant for media / entity‑reference fields: which image field of the referenced entity to render. |
| **Image loading** | The native browser `loading` attribute — **lazy** (default, defers off‑screen thumbnails for performance) or **eager**. |
| **Remove photoswipe‑gallery wrapper class** | Removes the wrapper class the module normally adds, so you can merge several fields into one shared gallery yourself. Off by default. |
| **Show download button** | Adds a download button to the lightbox toolbar so visitors can save images. Only available when the wrapper class is kept. |

The image styles you pick are recorded as dependencies of the display, so they
travel with configuration export/import.

## Grouping images into galleries

- A **multi‑value field** is automatically grouped into one gallery — the formatter
  adds a `photoswipe-gallery` wrapper class for you.
- In a **View**, the formatter opens single images by default. To make a gallery,
  add the `photoswipe-gallery` class to a wrapper (the field wrapper for one
  multi‑value field, or a row/inner wrapper to combine several fields).
- To **combine several fields or paragraphs** into one gallery, tick **Remove
  photoswipe‑gallery wrapper class** on each field and add your own
  `<div class="photoswipe-gallery">` around them.

## Global lightbox settings

Go to **Configuration → Media → PhotoSwipe** (`/admin/config/media/photoswipe`).
You need the **Administer site configuration** permission. The main options:

- **Load PhotoSwipe library from CDN** — load the PhotoSwipe (and caption) library
  from a CDN instead of `/libraries`. Off by default. Use this if you did not
  install the library with Composer.
- **Always load on non‑admin pages** — force the library to attach on every
  non‑admin page rather than only where a gallery is present. Off by default.
- **PhotoSwipe options** — a group of settings passed straight through to the
  PhotoSwipe JavaScript library, mirroring its API. These include:
  - the show/hide **animation type** (default *zoom*) and its durations,
  - **background opacity** (default `0.8`), spacing, and the initial / secondary /
    maximum **zoom levels**,
  - behaviour toggles such as **loop**, wheel‑to‑zoom, pinch‑to‑close, and the
    arrow/escape **key bindings** and click/tap actions,
  - the translatable **tooltips** — Close, Zoom, Previous, Next, and Download.

Click **Save configuration** when done. These settings are a config object, so they
export and deploy with `drush config:export` like any other configuration.

> **Tip:** To change lightbox options in code instead of on the form (for example
> to vary them per template), developers can use the `attach_photoswipe()` Twig
> function or the `hook_photoswipe_js_options_alter()` hook — see the
> [`agent/`](../agent/start.md) docs.
