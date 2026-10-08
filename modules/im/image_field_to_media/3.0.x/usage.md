Image field to media converts an existing core Image field into a Media (image) reference field: it adds a Media field to each bundle and, in a batch, backfills every entity with Media entities wrapping the same image files.

---

The module adds a "Clone to media" entity operation to every Image field row on *Manage fields* (for users with its permission). Selecting it first validates (via a controller) that an `image` Media type with a `field_media_image` field exists, then shows a form offering two paths: create a brand-new Media reference field, or reuse an existing Media reference field that targets the `image` bundle. On submit it optionally creates the field storage/instances and copies the source Image field's weight/label/formatter to the new field's form and view displays, then runs a batch (`image_field_to_media.batch.inc`) that walks all entities of the affected bundles which have the Image field and, for each image item, finds-or-creates an `image` Media entity and appends it to the Media field. Deduplication is by `sha1_file()` hash of the image file, tracked in state (`image_field_to_media.hashes_of_image_files`), so the same physical image maps to a single reused Media entity; hashes are cleaned up when media is deleted and on uninstall. The result is a Media field populated in parallel with the original Image field (the Image field is left intact). No config, routes are admin-only, and the single permission is `restrict access: true`. Requires core `media`.

---

- Migrate a legacy `image` field on a content type to a Media reference field.
- Add a new Media image field and backfill it from an existing Image field in one batch.
- Reuse an existing Media reference field instead of creating a new one.
- Convert image fields on nodes, taxonomy terms, and other fieldable entity types.
- Deduplicate: map identical image files (by sha1) to a single shared Media entity.
- Preserve the original field's weight, label, and image formatter settings on the new field.
- Keep the original Image field data intact during/after conversion (non-destructive).
- Modernize a site toward Media Library without manual re-uploads.
- Batch-process large content sets without timeouts.
- Trigger conversions from Manage fields via the "Clone to media" operation.
- Guard against missing `image` media type / `field_media_image` with a pre-check and clear messages.
- Convert multi-value (cardinality > 1) image fields, preserving cardinality on the new field.
- Set the new Media field's default form widget and view formatter from core's preconfigured media options.
- Programmatically clone image fields to media inside update hooks (supports empty-bundles mode).
- Prepare content for decoupled/Media-based workflows.
- Consolidate duplicate images across entities into reusable Media assets.
- Restrict the conversion capability to trusted admins via a restricted permission.
- Populate a Media field across all bundles that share an image field's storage.
- Clean up hash state automatically when Media entities are deleted.
- Provide a UI-driven alternative to hand-written migrations for image→media.
