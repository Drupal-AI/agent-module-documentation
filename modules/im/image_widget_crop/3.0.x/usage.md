ImageWidgetCrop adds an interactive crop widget (built on the Cropper JS library) to image fields, letting editors visually crop uploaded images per crop type using Drupal's Crop API.

---

The core Image module lets you upload images and apply image styles, but it gives editors no way to control *how* an image is cropped — the crop is decided globally by the image style. ImageWidgetCrop closes that gap by providing a field widget that swaps in for the standard image widget: when an editor uploads an image they get a live Cropper interface and can draw a crop box for each configured **crop type** (e.g. "16:9 hero", "square thumbnail"). Crops are stored through the contrib **Crop API** (`crop` module) as `crop` entities tied to the file, and the matching `crop_crop` image-effect then renders each style using the editor's chosen selection. The widget is configured per form-display: you pick which crop types appear, which are required, the preview image style, and whether to warn when a file is reused. A global settings form at Admin → Configuration → Media → Image Crop Widget controls the preview style, an optional external Cropper library/CSS URL, and notification behaviour. A `ImageWidgetCropManager` service applies, updates and deletes crops programmatically. The bundled `image_widget_crop_examples` submodule ships a ready-made content type demonstrating the widget with media, entity browser and inline entity form. It is a standard building block for editorial control over responsive images and art direction.

---

- Let editors crop an uploaded image directly in the node edit form.
- Provide different crop selections per crop type (16:9, 4:3, square) from one upload.
- Give art-directed responsive images where each breakpoint uses a different crop.
- Produce a hero-banner crop and a thumbnail crop from the same source image.
- Enforce a required crop so editors must define a focal region before saving.
- Preview the crop result live using a chosen preview image style.
- Attach cropping to any image field via the form-display widget settings.
- Crop images used inside Media entities and media library.
- Combine with Responsive Image module for breakpoint-specific crops.
- Warn editors when the same file is cropped in multiple places.
- Configure a global preview image style for all crop widgets.
- Load the Cropper JS library from a custom CDN or local path.
- Show or hide the default crop area when no crop exists yet.
- Notify editors when a crop is applied or updated.
- Programmatically apply a crop to a file with the crop manager service.
- Delete or update all crops for a file in custom code.
- Standardise product image framing in a Commerce catalogue.
- Let authors pick the focal point of portrait photos for square avatars.
- Crop images inside inline entity forms and entity browser widgets.
- Build an editorial workflow where thumbnails are never awkwardly auto-cropped.
- Re-crop existing images after changing crop-type aspect ratios.
- Offer a "square" crop for social-share cards separate from the article image.
- Demonstrate the widget quickly with the bundled examples content type.
- Keep original uploads intact while storing crop coordinates separately.
