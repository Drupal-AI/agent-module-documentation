<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elevate Image Zoom is an image field formatter that applies the ElevateZoom jQuery plugin, adding a hover/lens/inner magnify effect (and an automatic multi-image gallery) to core image fields.

---

Elevate Image Zoom ships one field formatter (`elevate_image_zoom_formatter`) that extends core's Image formatter and renders image fields with the third-party ElevateZoom JavaScript library. On a single-value field it outputs one zoomable image; on a multi-value field it renders a main image plus a thumbnail strip that acts as a gallery. Editors choose the effect per view-display from five zoom types — basic, tint, inner, lens and mousewheel — and configure the display image style, a separate high-resolution zoom image style, a thumbnail style, the tint overlay colour, the zoom-window position and size, and the lens size. The effect is presentation-only: it changes how an existing image field is displayed and does not alter media, access or stored data. The module requires the ElevateZoom library to be downloaded manually into `/libraries/elevatezoom/`; a `hook_requirements()` check reports an error on the status report until that file exists. It is in the Media package and defines no routes, permissions, services or configuration entities of its own.

---

- Add a magnify-on-hover zoom to product images on commerce or catalogue pages.
- Show a large zoomed preview in a floating window beside a product photo.
- Turn a multi-value image field into a thumbnail gallery with a zoomable main image.
- Give a jewellery or watch store close-up detail on hover.
- Let visitors inspect fabric or texture detail on apparel photos.
- Zoom high-resolution artwork or print reproductions on a gallery site.
- Display a tinted overlay zoom to emphasise the magnified region.
- Provide an inner (in-place) zoom that magnifies inside the image frame.
- Offer a round lens magnifier over a map or diagram.
- Enable mousewheel scroll zoom for fine-grained magnification control.
- Serve a separate high-resolution image style specifically for the zoom window.
- Use a smaller display image style for the on-page image to save bandwidth.
- Present real-estate floor plans or property photos with zoomable detail.
- Show museum or archive scans with a lens or inner zoom.
- Let shoppers compare thumbnails and zoom the selected one in a gallery.
- Add zoom to recipe or food photography for ingredient detail.
- Magnify technical/parts diagrams on documentation pages.
- Configure the zoom-window size and clock-position per image display.
- Apply different zoom types on different content types via view-display settings.
- Enhance a single-image "hero" field on a landing page with hover zoom.
- Provide zoomable close-ups for handmade or craft product listings.
- Display botanical or scientific specimen photos with lens magnification.
- Show detailed maps or infographics with an inner crosshair zoom.
- Improve the media UX on any node display that uses an image field.
