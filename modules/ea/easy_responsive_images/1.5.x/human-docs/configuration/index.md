# Configuration

There are three parts to using Easy Responsive Images: **generate** the image styles
from the settings form, then **display** your images with either the field formatter
or the Twig filter.

## Step 1 — Generate the image styles

1. Go to **Configuration → Media → Image styles → Generate image styles**
   (`/admin/config/media/image-styles/generate`). (This requires the *administer
   image styles* permission.)
2. Fill in the fields:
   - **Minimum width** / **Maximum width** — the smallest and largest widths (in
     pixels) you want styles for.
   - **Threshold width** — your preferred step between successive widths. The module
     walks from the minimum to the maximum in roughly this step.
   - **Aspect ratios** — optional, one `w:h` ratio per line (for example `16:9` or
     `4:3`). Each ratio produces a matching set of cropped styles.
   - **Minimum height** / **Maximum height** / **Threshold height** — optional; use
     these if you also want flexible-width styles constrained by height.
   - **Lazy loading threshold** — how far ahead (in pixels) the browser should start
     loading images with native lazy-loading. The default is **1250**.
3. Click **Save**.

> **A note on required fields:** if you fill in *any* of the width fields, all the
> width fields (including aspect ratios) become required as a group; the same is
> true for the height group. Fill in a complete group.

### What gets generated

On save the module creates image styles named with a `responsive_` prefix:

- **Scaled, flexible height** — `responsive_<width>w`, e.g. with min 300 / max 900 /
  step 300 you get `responsive_300w`, `responsive_600w`, `responsive_900w`.
- **Cropped to an aspect ratio** — `responsive_<w>_<h>_<width>w`, e.g. a 16:9 ratio
  gives `responsive_16_9_300w`, `responsive_16_9_600w`, and so on. These crop to the
  focal point when Focal Point is installed, otherwise they scale-and-crop to the
  centre.
- **Fixed height, flexible width** — `responsive_<height>h`, if you filled in the
  height group.

Every time you save, any old `responsive_`-prefixed style that is no longer part of
the new set is **deleted**, so re-running the form to adjust your range keeps things
clean.

### Deleting all generated styles

The generator form has a **Delete generated image styles** button that removes every
image style whose name starts with `responsive_`. Use it if you want to start over
or remove the module's styles before uninstalling.

## Step 2a — Display with the field formatter

The simplest way to output responsive images:

1. Go to an image field's **Manage display**, e.g.
   *Structure → Content types → Article → Manage display*
   (`/admin/structure/types/manage/article/display`).
2. In the field's **Format** column, choose **Easy Responsive Images**.
3. Click the gear/cog to set its options:
   - **Image handling** — *Scale* (flexible height, keeps the original ratio) or
     *Aspect ratio* (crop to one of your generated ratios). The *Aspect ratio*
     option only appears if you generated aspect-ratio styles.
   - **Aspect ratio** — which generated ratio to use (only when *Image handling* is
     *Aspect ratio*).
   - **Multiplier** — load a larger derivative for sharper images on high-resolution
     / high-DPI screens (`1x`, `1.25x`, `1.5x`, `2x`, `3x`, `4x`).
   - **Cover** — also take the container's **height** into account when choosing the
     best image (useful for `object-fit` layouts).
4. Click **Update**, then **Save**.

The formatter emits an `<img>` with a full `data-srcset` of the matching derivatives.
The module's bundled JavaScript then measures the real space the image occupies and
swaps in the best-fitting size. If you have WebP/AVIF modules installed, it serves
those formats automatically.

> The formatter needs the `responsive_` styles to exist first (Step 1). For *Aspect
> ratio* handling, the chosen ratio's styles must have been generated.

## Step 2b — Display with the Twig filter

For custom templates where you want to build the markup yourself, use the
**`image_url`** Twig filter. It turns a file URI plus a style name into a URL for
that derivative:

```twig
{# a single src #}
{% set src = file.uri.value|image_url('responsive_16_9_50w') %}

{# a hand-built srcset #}
{% set srcset = [
  file.uri.value|image_url('responsive_16_9_150w') ~ ' 150w',
  file.uri.value|image_url('responsive_16_9_550w') ~ ' 550w',
  file.uri.value|image_url('responsive_16_9_1250w') ~ ' 1250w',
] %}
```

To get the automatic "load the best size" behaviour in your own markup, attach the
resizer library and output a `data-srcset`:

```twig
{{ attach_library('easy_responsive_images/resizer') }}
<img
  src="{{ src }}"
  data-srcset="{{ srcset|join(',')|raw }}"
  alt="{{ media.field_media_image.alt }}"
  loading="lazy"
  width="50" height="50" />
```

The filter returns a WebP or AVIF URL automatically when those modules are present,
and resolves remote images through Imagecache External when that module is
installed.

## Where the settings are stored

The generator's inputs are saved in the `easy_responsive_images.settings`
configuration object, and the generated styles are ordinary image-style config
entities (each named `responsive_…`). You can inspect them with:

```bash
drush cget easy_responsive_images.settings
drush config:status | grep responsive_
```

Because everything is config, you can export your settings and generated styles and
deploy them across environments.
