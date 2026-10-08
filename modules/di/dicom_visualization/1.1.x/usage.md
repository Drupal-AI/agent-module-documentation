Renders DICOM (.dcm) medical images inside Drupal by adding an interactive Cornerstone.js viewer as a formatter on the core File field.

---

DICOM Visualization attaches to Drupal's core File field rather than introducing a new entity or media type. Once a File field allows the `.dcm` extension, its display formatter can be switched to one of two viewers: the standard "DICOM File Formatter (Legacy)" (`dicom_file_formatter`), which overlays admin-chosen DICOM metadata tags in the four viewport quadrants, or the "Dicom Advanced File Formatter" (`dicom_adv_file_formatter`), which adds 15+ colour themes and a combined stack/gallery mode for multi-value fields. The client viewer is the Cornerstone.js stack (cornerstone-core, cornerstone-tools, cornerstone-wado-image-loader, dicom-parser, hammerjs) pulled from a CDN, giving mouse-wheel zoom, window leveling and panning. A global settings form at `/admin/dicom-configuration` controls which of the 45+ known DICOM tags are shown, their prefix labels, viewport quadrant, display order, overlay text colour and whether zoom is enabled. A "Dicom File Widget" extends the core file upload widget for the edit form. The module depends only on the core File module.

---

- Display CT, MR, ultrasound or X-ray DICOM studies on a Drupal node without external viewer software.
- Add a File field to a content type, allow the `dcm` extension, and render it as a medical image viewer.
- Overlay Patient ID, Patient Name, Modality and Study Date on top of the rendered image for quick identification.
- Map specific DICOM tags to the top-left, top-right, bottom-left or bottom-right viewport quadrants.
- Customise the label prefix shown before each metadata value (e.g. "Patient Ref: " instead of "Patient ID: ").
- Control the display order of stacked metadata overlays within each quadrant.
- Set a global overlay text colour to match a site or clinical theme.
- Enable or disable mouse-wheel zoom / window-level / pan interaction globally.
- Choose one of 15+ built-in viewer colour themes (Midnight Blue, Emerald, Ruby, Cyberpunk, Medical Bone, light clinic themes, etc.) per field display.
- Show multiple DICOM files in a single field as individual side-by-side viewers.
- Show multiple DICOM files as a single combined stack/gallery viewer for scrolling through a series.
- Use the advanced formatter's theme + multi-file settings independently per view mode (teaser, full, etc.).
- Build a teaching archive where each case node carries its DICOM series and metadata overlays.
- Present research imaging datasets to reviewers directly in the browser with pan and zoom.
- Provide window leveling (brightness/contrast) so viewers can inspect soft-tissue vs. bone windows.
- Attach DICOM files with the "Dicom File Widget" on the node edit form.
- Link editors from a File field's formatter settings summary straight to the global tag configuration page.
- Extract and display metadata client-side via dicom-parser without a server-side DICOM library.
- Reuse the core File field's own access, storage (public/private) and cardinality settings for the imaging field.
- Render a scrollable series gallery for modalities that produce many slices.
- Configure per-tag enable/disable so only clinically relevant metadata appears on the overlay.
- Style the viewer for kiosk or tablet use with touch/gesture support via hammerjs.
