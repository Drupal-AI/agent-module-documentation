<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crop Image lets one image be reused with a different crop in each place it appears, by transparently duplicating the file behind the scenes and cropping the copy — and adds an Entity Browser-backed field widget so editors can crop images picked from the existing image library instead of only uploading new ones.

---

The problem it fixes is specific to how `image_widget_crop` and the core Crop API work: a crop is stored keyed by the image **file's URI**, so a single source image reused across several nodes can hold only **one crop per crop type**. Set a 16:9 crop for the hero on page A and the same file's 16:9 crop changes on page B. Crop Image removes that constraint not by changing where crops are stored but by giving each usage its **own physical file to crop**. When an entity that uses the "ImageWidget crop (with browser)" widget is saved, `hook_entity_presave` (`CropImageManager::validateCropImages`) copies the selected source file to a `crop-duplicate-N-for-<name>` file, records the relationship in a `crop_duplicate` content entity (source file id, duplicate file id, owning entity type/uuid, field name, delta), swaps the field's `target_id` to the duplicate, and lets `image_widget_crop` apply the manual crop to that copy. When the reference goes away or the entity is deleted, `hook_entity_delete`/presave cleanup deletes the orphaned duplicate and its file-usage records, so editors never manage the copies themselves. It is therefore a **glue module**, hard-depending on `image_widget_crop` and `entity_browser (>=2.10)` (which pull in core `crop`); the actual crop UI (Cropper.js) comes from `image_widget_crop`, and the browser/upload UI from `entity_browser`. The widget `entity_browser_image_crop` extends Entity Browser's `FileBrowserWidget`, injecting an `image_crop` element per selected image; a settings form at `/admin/config/media/crop-image` (permission `administer site configuration`) sets widget defaults and an optional "automatic crop" that fills in a centered default crop when the editor sets none. Also shipped: a `crop_image` **media source** (extends core Image) for using the widget on media, and a "Generate default crop" **Views Bulk Operations** action to backfill centered default crops on many files at once. Because it leans on Entity Browser — an older selection architecture that core Media Library has largely displaced — weigh it against staying on the core library, and against `focal_point` when a single focus point (rather than an independent rectangle per usage) would do.

---

- Give the same image a different 16:9 crop on two different pages.
- Crop a hero image per node without changing the image elsewhere.
- Reuse a library photo but frame it independently in each usage.
- Pick an existing image from the library and crop it inside the edit form.
- Upload or browse-and-select an image, then crop, in one widget.
- Apply multiple crop types (thumbnail, banner, square) to one selection.
- Make certain crop types required before the form can be saved.
- Auto-fill a centered default crop when an editor sets none (automatic crop).
- Backfill default crops across many files with a bulk operation.
- Use the crop-enabled widget on a Media entity via the Crop Image media source.
- Keep the original library file untouched while cropping a per-usage copy.
- Avoid the "one crop per file URI" limit of image_widget_crop.
- Let editors crop at selection time instead of editing each media item.
- Support several aspect ratios on a single image field.
- Show a crop-zone preview using a chosen image style while editing.
- Expose remove / replace buttons on selected images in the widget.
- Clean up duplicate crop files automatically when references are removed.
- Set site-wide widget defaults from one settings form.
- Integrate cropped-file previews with file_entity view modes when present.
- Keep duplicate and original filenames aligned when filefield_paths rewrites paths.
- Provide independent per-context framing for cards, teasers, and banners.
- Migrate an editorial workflow from per-media crops to per-usage crops.
