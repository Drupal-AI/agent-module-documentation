<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Sizes Extras is an add-on formatter for the Image Sizes module that, instead of swapping the whole image URL, outputs a browser-native `srcset` and uses a JavaScript ResizeObserver to set the `sizes` attribute dynamically so the browser picks the best candidate — including for high-DPI screens.

The `image_sizes_extras_formatter` field formatter extends Image Sizes' `ImageSizesPresetFormatter`, removes the `load_invisible` setting, and re-themes each rendered item with the `image_sizes_extras` theme hook, attaching the `image_sizes_extras/core` JS library. The result is a single `<img>` with a full `srcset` whose `sizes` value is recomputed from the element's real rendered width, letting the browser choose the correct source and support 2x DPI when the preset ceiling is large enough. The README advises presetting up to ~2× the maximum display width for retina support, and notes the preload image style's width/height set the aspect ratio (which can cause slight layout shift for presets without a fixed ratio).

It depends on the Image Sizes module (whose presets it consumes), adds no routes/permissions/services/forms, and is applied purely on a field's *Manage display*. Field types: image and entity_reference.
---
An Image Sizes add-on formatter that emits native srcset and sets sizes dynamically via ResizeObserver for truly responsive, DPI-aware images.
---
- Render an image field with a native srcset
- Let the browser pick the best image candidate
- Support 2x/high-DPI screens with larger presets
- Dynamically set the sizes attribute from rendered width
- Use a ResizeObserver to react to layout changes
- Replace URL-swapping with browser-native selection
- Apply to image fields via Manage display
- Apply to entity_reference (media) image displays
- Reuse existing Image Sizes presets
- Reduce layout shift by presetting aspect ratios
- Avoid loading oversized images on small viewports
- Serve appropriately sized images per container width
- Drop the load_invisible option from the formatter
- Theme output via the image_sizes_extras template
- Attach the image_sizes_extras/core JS library automatically
- Pair with Image Sizes presets sized ~2x display width
