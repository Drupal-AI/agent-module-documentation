Image Field Caption adds an optional rich-text caption to Drupal core image fields, entered per image in the edit form and rendered under the image by a dedicated "Image with caption" field formatter.

---

The module extends core's image field rather than defining a new field type: `hook_field_info_alter()` swaps the `image` field item class to `ImageCaptionItem`, which adds three per-field settings — `caption_field` (enable), `caption_field_required`, and `default_image.caption`. When `caption_field` is enabled, a `hook_field_widget_single_element_form_alter()` process callback injects an extra `text_format` element (`image_field_caption`) into the image widget, so each image delta gets a filtered/formatted caption plus format selector. Display uses a field formatter plugin `image_caption` ("Image with caption") that subclasses core `ImageFormatter` and swaps the theme hook to `image_caption_formatter`, whose template wraps the caption in `<blockquote class="image-field-caption">`. Caption text is NOT stored in the field's own columns: the `image_field_caption.storage` service (`ImageCaptionStorage`) persists captions in standalone `image_field_caption` (and `image_field_caption_revision`) tables keyed by entity_type, bundle, field_name, entity_id, revision_id, language and delta, cached in `cache.data`. Entity hooks glue the two together — `hook_entity_storage_load()` merges stored captions back into the loaded image item values, while `hook_entity_insert()`/`hook_entity_update()`/`hook_entity_delete()` write and remove them. There is no admin settings page (no `configure` route); everything is configured per image field on Manage form display / field settings and Manage display. The module ships no permissions, Drush commands, or config schema. Note the revision table exists but revision read/write is commented out in the source, so captions are effectively current-revision only.

---

- Add a descriptive caption beneath images on article or blog content types.
- Give photo galleries per-image captions with formatted (HTML) text.
- Provide credit/attribution lines under images using an allowed text format.
- Attach captions to image fields on any fieldable entity (nodes, media, taxonomy terms, users, paragraphs).
- Enable the "Image with caption" formatter on Manage display to render captions.
- Require editors to fill in a caption by turning on the "Caption field required" setting.
- Let captions carry rich text (links, emphasis) via a text-format selector per image.
- Support multi-value image fields — each delta gets its own caption.
- Store captions in a dedicated table so they don't alter the core image field schema.
- Theme the caption markup by overriding `image-caption-formatter.html.twig` in your theme.
- Style captions with the `blockquote.image-field-caption` CSS selector.
- Keep per-language captions on translated entities (language is part of the storage key).
- Use captions as an alternative to overloading the image `title`/`alt` attributes.
- Programmatically read a caption via the `image_field_caption.storage` service `getCaption()`.
- Programmatically insert or delete captions from custom code with the storage service.
- Check whether a caption exists for a given entity/field/delta with `isCaption()`.
- Add captions to images embedded in Paragraphs (widget process handles `#field_parents`).
- Migrate legacy image captions into the `image_field_caption` table via the storage API.
- Show captions only when an image is present (caption element hides when no file is uploaded).
- Provide a default caption for a field's default image via the `default_image.caption` setting.
- Invalidate caption caches per field using the storage service `clearCache()`.
- List distinct entity types or bundles that have captions with the storage `list()` method.
- Render captions as processed text respecting the stored text format on display.
- Add captions without writing a custom field type or extending the database field tables.
- Combine with image styles — the formatter still applies the chosen image style to the image.
