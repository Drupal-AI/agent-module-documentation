# Configuration

Drimage has two layers of configuration: **global settings** that govern how styles
are generated across the site, and **per-field formatter settings** you set on each
image field's display.

## Global settings

1. Log in as a user with the **Administer image styles** permission.
2. Go to **Configuration → Media → Drimage**, or navigate directly to
   `/admin/config/media/drimage`.

The keys, with defaults:

- **Threshold** (default `200`) — the minimum pixel difference between two generated
  styles; requested widths are snapped to a multiple of this. Larger = fewer distinct
  styles generated.
- **Ratio distortion** (default `60`) — how much ratio distortion is tolerated when
  reusing a near-matching existing style instead of creating a new one.
- **Upscale** (default `320`) — the smallest width a style is generated at. Requests
  below this are rejected (the fallback style is used).
- **Downscale** (default `3840`) — the largest width generated. Requests above this are
  rejected. Use this to cap disk usage.
- **Multiplier** (default on) — enable device-pixel-ratio detection so retina/HiDPI
  screens get higher-resolution derivatives.
- **Lazy offset** (default `100`) — how many pixels before an image enters the viewport
  the lazy-loader starts fetching it.
- **Core WebP** (default off) — add a core GD convert-to-WebP effect to generated
  styles.
- **ImageAPI Optimize WebP** (default off) — serve WebP through the
  `imageapi_optimize_webp` pipeline instead of core GD.
- **Automated crop** (default empty) — choose an `automated_crop` provider for crops
  (only when that module is present).
- **Fallback style** (default empty) — the image style delivered when the requested
  dimensions are invalid or generation fails.
- **Cache max-age** (default `0`) — browser cache max-age for delivered derivatives;
  `0` means `must-revalidate, no-cache, private`.
- **Legacy lazyload** — use Drimage's own JS lazyloader instead of native browser lazy
  loading. This option is hidden unless it's already in use.

> Note: only the requested **width** is validated against upscale/downscale/threshold.

## Per-field formatter settings

On each entity's **Manage display** tab (e.g. **Structure → Content types → *(type)* →
Manage display**), set the field's format to **Drimage**. Because Drimage computes the
image style itself, this formatter deliberately has **no image-style select** — but it
keeps core's image-link and loading-attribute options. Its settings:

- **Image handling** — how the image is fitted:
  - **Scale** — scale to the rendered width.
  - **Aspect ratio** — crop to a fixed ratio at the display size.
  - **Background** — output as a CSS `background-image`.
  - **Image Widget Crop (iwc)** — only shown if the Image Widget Crop module is
    enabled.
- **Aspect ratio** — the target `width:height` (1–100 each, default 1×1) used when
  *Image handling* is **Aspect ratio**.
- **Background** — CSS background rules (attachment scroll/fixed, position, size) used
  when *Image handling* is **Background**.
- **Crop-type style** — the crop-type image style used when *Image handling* is **iwc**.
- **Image link** and **loading attribute** — inherited from the core image formatter
  (link target, native `loading` attribute).

There's also a `drimage_uri` formatter for rendering an image **URI** field
responsively.

## Managing generated styles

Drimage names its auto-generated styles `drimage_<width>_<height>` (with variants for
focal point and crop types). **Don't create these by hand.** They're pruned
automatically on config import and on relevant module install/uninstall so they
regenerate cleanly.

To wipe them manually — for example to reclaim disk or force a rebuild after changing
global settings — use the Drush command:

```bash
# Delete every auto-generated Drimage image style.
ddev drush drimage:delete-styles

# Delete only the styles for a specific crop type.
ddev drush drimage:delete-styles --crop-type=<crop_type_id>
```

Styles regenerate on demand on the next front-end request, so this is safe to run.
