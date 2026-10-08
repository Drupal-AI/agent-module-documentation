<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elevate Image Zoom (project `elevatezoom`) provides an image field formatter that adds a jQuery ElevateZoom Plus magnify/zoom effect — plus a multi-image gallery and lightbox mode — to image fields.

---

Elevate Image Zoom integrates the jQuery **ElevateZoom Plus** plugin as a Drupal image field formatter (plugin id `elevatezoom_formatter`, label "Elevate Image Zoom"). It extends core's `ImageFormatter`, so it applies to any `image` field and is selected per view display on *Manage display*. Each configured field renders its image(s) with a chosen zoom behaviour — Basic, Tint, Inner, Lens, Mousewheel, or Lightbox & Gallery — driven by per-formatter settings (image styles for the display image, the high-resolution zoom image and thumbnails; overlay/tint colour; zoom-window position, width and height; lens size). When a field holds more than one image the formatter switches to a thumbnail gallery with a main zoom image, and the Lightbox type opens a Fancybox-Plus overlay. The ElevateZoom Plus and Fancybox-Plus JavaScript loads either from a jsDelivr CDN (default) or from a locally installed copy under `/libraries/elevatezoom/`, controlled by the formatter's "Use CDN" checkbox. The module ships no routes, permissions, services or config entities — all configuration lives in the field's view-display settings.

---

- Add a hover magnifier to product images on commerce/catalogue nodes.
- Give detail/spec images a zoomed close-up window beside the thumbnail.
- Turn a multi-value image field into a thumbnail gallery with a main zoom image.
- Provide a Fancybox-Plus lightbox overlay for a gallery of product photos.
- Show fine detail on artwork, textiles or jewellery photography.
- Apply an inner (in-place) zoom that magnifies within the image frame.
- Use a lens-style round magnifier that follows the cursor.
- Enable mousewheel/scroll zoom to vary magnification level.
- Add a tinted overlay effect to the non-zoomed area of the image.
- Serve a small display image style but a high-resolution image style for the zoom pane.
- Generate thumbnails via an image style for gallery navigation.
- Configure the zoom window's clockwise position (1-16) around the image.
- Set the zoom window's pixel width and height per display.
- Control the lens size for lens-type zoom.
- Choose the overlay/tint colour with a colour picker.
- Load the zoom library from a CDN so no library download is required.
- Switch to a self-hosted `/libraries/elevatezoom/jquery.elevatezoom.js` copy for offline/air-gapped sites.
- Present zoomable images in a responsive Bootstrap-style grid layout.
- Show per-image captions from the image field's title text.
- Apply different zoom types to different image fields or view modes.
- Enhance real-estate or property-listing photo galleries.
- Improve documentation/manual pages that show annotated screenshots.
- Add an interactive zoom to museum or archive digital-collection images.
- Give menu/food photography a close-up view on restaurant sites.
- Configure everything per view-display without writing code.
