<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Sizes Extras (image_sizes_extras) — agent index

**Add-on formatter for Image Sizes that emits a native `srcset` and sets `sizes` dynamically via a ResizeObserver, so the browser selects the right (DPI-aware) image.**

- **Version:** 1.0.x · **Core:** ^9 || ^10 || ^11 · **Package:** Media
- **Depends on:** `image_sizes` · **Library:** `image_sizes_extras/core`
- **Formatter:** `image_sizes_extras_formatter` (field types image, entity_reference) — extends `ImageSizesPresetFormatter`; removes `load_invisible`; re-themes items as `image_sizes_extras`
- **Setup:** choose the formatter on a field's Manage display; configure presets in Image Sizes

**Security:** Pure display formatter — no routes, permissions, services, or forms; no user-input sinks. No security impact.
