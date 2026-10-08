# Configuration

Drimage has two places you configure it: a **global settings form** that controls
how sizes are generated site‑wide, and a **per‑field formatter** where you choose
how each image is cropped or scaled. Both ship with defaults, so you can leave
everything alone and Drimage still works.

## Global settings — `/admin/config/media/drimage_improved`

1. Log in as a user with the **Administer image styles** permission.
2. Go to **Configuration → Media → Drimage**, or navigate directly to
   `/admin/config/media/drimage_improved`.

The form controls the "grid" of sizes Drimage is willing to generate, and how the
derivatives are produced:

- **Threshold** *(default 200)* — the minimum difference, in pixels of width,
  between two generated styles. A larger number means fewer distinct image styles
  (and less disk use), at the cost of images being sized a little less precisely.
- **Ratio distortion** *(default 60)* — how much an existing style's aspect ratio
  may differ (measured in arc‑minutes) before Drimage reuses it instead of
  creating a brand‑new style. Higher values reuse more aggressively.
- **Upscale** *(default 320)* — the minimum width Drimage will generate. Requested
  sizes below this are floored to it, so tiny images aren't produced.
- **Downscale** *(default 3840)* — the maximum width Drimage will generate. This
  caps very large displays and retina requests.
- **Multiplier** *(default 1)* — a device‑pixel‑ratio multiplier, used to serve
  sharper images on high‑density (retina) screens.
- **Lazy offset** *(default 100)* — how far, in pixels, below the viewport an image
  starts loading, so it's ready by the time the visitor scrolls to it.
- **Convert to WebP with core** *(on by default)* — deliver modern WebP
  derivatives through Drupal core's image toolkit.
- **Use ImageAPI Optimize WebP** *(off)* — produce WebP through the
  imageapi_optimize_webp module instead of core, if you have it installed.
- **Automated crop provider** — the id of an Automated Crop provider to apply to
  on‑the‑fly crops (used together with Image Widget Crop).
- **Fallback style** — an image style to deliver if generation fails or the
  requested dimensions are out of range. It is empty by default; setting one is a
  good safety net.
- **Cache max‑age** *(default 0)* — how long delivered images may be cached.
- **Placeholder color** *(default `#ffffff`)* — the solid color shown in the
  placeholder while the real image loads.
- **Use a placeholder image** *(off)* — switch from a solid color to an image
  placeholder, whose path you set in the field beneath it.
- **Legacy lazyload** — use Drimage's own JavaScript lazyloader rather than the
  browser‑native one.

Click **Save configuration** when done. If you tighten the grid (for example raise
the threshold) and want to clear the styles already generated under the old
settings, run `drush drimage_improved:delete-styles`; they regenerate on demand.

## Per‑field formatter — "Dynamic Responsive Image"

The rest of the configuration lives on each image field. Go to **Structure →
Content types → *(your type)* → Manage display**, set the field's format to
**Dynamic Responsive Image**, and click the gear icon.

Note that this formatter deliberately **removes** the usual "Image style" select —
Drimage computes the style for you. Instead you pick an **image handling** mode:

- **Scale** — scale the image to the measured width and keep its own aspect ratio.
  This is the simplest, most common choice.
- **Aspect ratio** — crop to a fixed ratio you enter (for example 16 × 9), so every
  rendered image matches regardless of the original's shape.
- **Background** — output the image as a CSS background, with your own
  *attachment*, *position*, and *size* settings.
- **Container size** — size the image to its container rather than to its own
  aspect ratio.
- **Image Widget Crop** — use a named crop type from the Image Widget Crop module.
  This option only appears when that module is enabled.

As with any formatter, you can also link the rendered image to its content or to
the file. Save the display, and Drimage takes it from there.

## Optional integrations

Drimage recognizes several modules automatically when they are present:
**Focal Point** (focus‑aware crop styles), **Image Widget Crop** (named crop types),
**Automated Crop**, **ImageAPI Optimize WebP** (WebP optimization), and
**Stage File Proxy**. Installing any of them simply unlocks the matching options
above — there is nothing extra to switch on inside Drimage itself.
