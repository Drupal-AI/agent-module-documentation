AI Image Bulk Alt Text adds an admin form that lists every image field missing alt text across the site and lets you generate and save AI alt text for many of them at once.

---

This submodule of AI Image Alt Text provides a single admin form (`AltTextFixer`) at
**Admin → Config → Media → Bulk Generate Alt Text with AI**
(`/admin/config/media/ai_image_bulk_alt_text`, permission `batch fix ai images alt text`).
On load it scans all content entity types and bundles for image fields that have alt text
enabled, then finds field items whose `alt` value is empty (up to a 50-item limit) and
renders one table row per image: a thumbnail, the owning entity + field, an editable "New
Alt Text" textarea, and a per-row "Generate with AI" button. A "Bulk Generate Alt Text with
AI" button (JS in `js/suggest.js`) fires generation for every row, reusing the parent
module's generate route / AI Core `chat_with_image_vision` path and dropping each suggestion
into its textarea. Nothing is written until you press "Save changes", which loads each entity,
sets the `alt` on the field, and saves it — keeping a human in the loop. It defines no config,
no schema, and no services of its own; it depends entirely on `ai_image_alt_text` (and through
it, AI Core) for the actual AI call.

---

- Fill in missing image alt text across the whole site in one place.
- Review every image lacking alt text on a single admin screen.
- Bulk-generate AI alt text for many images with one button.
- Generate alt text per row when you only want to fix specific images.
- Edit the AI suggestion in a textarea before saving it.
- Save all reviewed alt text changes at once with "Save changes".
- Remediate accessibility gaps in an existing media library after installing the module.
- Improve image SEO retroactively across old content.
- See a thumbnail of each image alongside its owning entity and field name.
- Target any content entity type with an image field that has alt text enabled.
- Skip images that already have alt text (only empty ones are listed).
- Keep a human in the loop: nothing is auto-saved until you confirm.
- Reuse the site's configured AI provider/model from the parent module.
- Generate per-entity-language alt text (row buttons pass the entity language).
- Restrict access with the `batch fix ai images alt text` permission.
- Batch-clean alt text after a bulk content import that left images undescribed.
- Confirm you are "all good" when the form reports no missing alt text.
- Process large libraries in chunks (the scan is capped, so repeat until clean).
