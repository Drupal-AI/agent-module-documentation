<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flexi Gallery is an image-field formatter that renders a multi-value image field as a flexible gallery: a set of large images plus a row of small thumbnails, with optional links to the original and optional lightbox integration.
---
The `flexi_gallery` FieldFormatter builds two render sets — big images and small thumbnails — each with its own configurable image style, and can wrap big images in a link to the original (raw or via an image style), open them in a Colorbox or Fancybox lightbox, and limit how many thumbnails are visible. Rendering goes through a theme hook and Twig template using core's `image`/`image_style` render elements and `Attribute` objects, so markup and image derivatives are handled by core. Colorbox/Fancybox are attached only when those integrations are selected (and their modules present).

Setup: enable the module, then on an image field's *Manage display* choose the **Flexi Gallery** formatter and configure big/small image styles, link-to-original, lightbox choice, and the visible thumbnail count. It is a display-only formatter — no routes, permissions, or stored config beyond the formatter settings schema.
---
- Render an image field as a big-image + thumbnail gallery
- Set a distinct image style for big images
- Set a distinct image style for thumbnails
- Link big images to the original file
- Link big images to an image-style derivative of the original
- Open big images in a Colorbox lightbox
- Open big images in a Fancybox lightbox
- Limit the number of visible thumbnails
- Show only big images or only thumbnails
- Build a product image gallery on a content type
- Build a portfolio/photo gallery display
- Reuse core image styles for responsive derivatives
- Attach lightbox libraries only when enabled
- Theme the gallery via the flexi-gallery template
- Add custom attributes to the big-image wrapper
- Provide a clickable thumbnail strip under a hero image