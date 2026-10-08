<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDF Preview Image auto-generates a first-page preview image of an uploaded PDF and stores it in a separate image field on the same entity.

---

PDF Preview Image is a lightweight field enhancement, not a formatter or a new field type. When a core file field accepts the `pdf` extension, the module adds a "PDF preview auto-generation" section to that field's Field UI edit form: a checkbox to enable generation and a select box choosing which image field on the same bundle should receive the preview. Once enabled, every time an entity is saved (`hook_entity_presave()`) the module loads the referenced PDF, checks its MIME type is `application/pdf`, rasterises the first page to a `.jpg` using the `spatie/pdf-to-image` library (Imagick PHP extension backed by ImageMagick + Ghostscript), creates a managed file for the image, and sets it on the target image field. If the PDF field is cleared, the previously generated preview file is deleted and the target field emptied. The module has no routes, permissions, services, config objects, or Drush commands — it is entirely driven by the two third-party settings it attaches to eligible file fields. Because it rasterises stored PDFs through ImageMagick/Ghostscript, keep that server-side toolkit installed and current, and confirm PDF delegate support is enabled.

---

- Auto-generate a cover thumbnail for an uploaded PDF document.
- Show the first page of a PDF as an image on a node display.
- Give a document library visual PDF previews instead of generic file icons.
- Populate an image field automatically from a PDF file field on the same content type.
- Create catalogue/brochure thumbnails from uploaded PDFs.
- Attach a preview image to press releases, datasheets, or reports stored as PDF.
- Build a resource-download list where each item shows its PDF cover.
- Provide a teaser image for a PDF referenced from a paragraph or media entity bundle.
- Keep previews in sync: clearing the PDF field removes the generated image automatically.
- Regenerate the preview on every save so replacing the PDF replaces its thumbnail.
- Use core Image styles on the generated preview field to size/crop thumbnails.
- Add PDF cover art to a Views listing by displaying the target image field.
- Enable previews only on specific file fields by toggling the per-field checkbox.
- Route previews of different bundles into different image fields per content type.
- Offer editors a zero-effort thumbnail workflow (upload PDF, save, image appears).
- Feed the generated image field into social/OpenGraph meta or card layouts.
- Provide document icons for a knowledge base or intranet file repository.
- Complement Media entity bundles that store PDFs with an auto image preview.
- Replace a heavier "PDF to image field" workflow with a minimal, field-driven one.
- Ensure previews are managed files (garbage-collected via normal file usage rules).
- Standardise document thumbnails across a site without manual image uploads.
