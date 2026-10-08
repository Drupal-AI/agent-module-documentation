Image Crop Widget ("Imager Widget") is a field widget for core Image fields that lets content authors rotate, crop and resize an uploaded image directly in the edit form, in the browser, before saving the node/media.

---

The module ships a single field widget plugin, `imagecroper` (labelled "Imager Widget"), that extends core's `ImageWidget` and works on any `image` field. After a file is uploaded, the widget renders a **"Start Editing"** button; clicking it loads the bundled [ImagerJS](https://github.com/cyberalien/imagerjs) editor (Rotate, Crop, Resize, Undo, Save toolbar) over the preview. When the user clicks ImagerJS's save icon, the edited image is captured as a base64 data-URI into a hidden textarea; on form submit `massageFormValues()` decodes it and, depending on the widget's **"Type of update image"** setting, either **replaces** the original managed file in place (and flushes derived image-style copies, including `.webp`) or **creates a new** managed file (`public://<original-name>`, renamed on collision) and points the field at it. There is no global settings page (`configure` is null) and the module defines no permissions or Drush commands; you configure it entirely on an entity's *Manage form display* tab by choosing the widget for an image field. A `hook_field_widget_info_alter()` also re-registers the widget so it is offered for the core `image_image` widget's field types. The editor assets (ImagerJS JS/CSS, jQuery, a small `imager_widget.js` glue) load from the module's own `imagerjs` library — no CDN.

---

- Let content editors crop an uploaded image inside the node form without leaving the page.
- Rotate a photo that was uploaded in the wrong orientation before saving.
- Resize/scale down an oversized image at edit time.
- Replace the original file in place so all existing references and image styles pick up the edit.
- Keep the original and save the crop as a brand-new managed file instead.
- Provide a lightweight in-browser image editor for authors who have no desktop image tool.
- Add crop/rotate to an existing image field by just switching its form-display widget.
- Offer image editing on a Media entity's image field via Manage form display.
- Automatically clear stale image-style derivatives (and WebP variants) after an in-place edit.
- Give a simple "fix this image" affordance on user-facing content submission forms.
- Straighten or re-frame product photos in a commerce catalog before publishing.
- Crop avatar/profile images to a consistent framing at upload time.
- Let editors trim whitespace or unwanted borders from screenshots.
- Reuse the widget for any custom entity type that has an image field.
- Undo an in-progress edit with ImagerJS's Undo before saving.
- Avoid a separate crop module/UI for quick one-off image tweaks.
- Preserve the original filename when replacing an edited image in place.
- Serve the image editor entirely from the site (no external CDN dependency).
- Provide touch-friendly crop/rotate controls on tablets (ImagerJS touch CSS).
- Apply quick edits to gallery images managed through content types.
