<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG Image Widget Crop (svg_image_widget_crop) — agent index

**Overrides the `image_crop` form element so SVG uploads skip the Image Widget Crop UI (vectors can't be cropped).**

- **Version:** 1.x  •  core `^8.8 || ^9 || ^10 || ^11`  •  deps: image_widget_crop, svg_image
- **Code:** one class, `src/Element/ImageCrop.php`, extending IWC's `ImageCrop`; `processCrop()` returns early for `image/svg` MIME when `svg_image` is enabled.
- **Surface:** no routes, permissions, services, or config. Zero configuration — behaviour is automatic.
- **Security:** no anonymous/mutating endpoints. Does not render or sanitise SVGs (only bypasses cropping); SVG rendering/sanitisation belongs to the `svg_image` dependency. No security findings.