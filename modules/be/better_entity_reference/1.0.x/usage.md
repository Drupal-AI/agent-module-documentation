Better Entity Reference gives entity-reference, list, media, file and image fields a tag/tile widget with a search-upload-browse popover, plus a matching Better Tags formatter.

---

The module ships five field widgets and two form elements that replace Drupal's default select/autocomplete/upload UIs with a compact interface: picked values render as colored, reorderable tags (or thumbnail tiles for files/media) and a round "+" opens a popover to search, sort, filter, browse hierarchical vocabularies folder-by-folder, upload files, or pick from a file browser. Entity-reference widgets keep the value in core's own input, so they degrade to the plain autocomplete when JavaScript is off. File/image/media widgets chunk-upload through the module's own endpoints while enforcing the field's own extension/size validators and destination, and every endpoint is protected by a session CSRF token, a field-bound HMAC signature, and per-result view/create access checks. Tag colors are stable per entity (random, shades of a base color, or one fixed color) and can be overridden via an entity color field or `hook_better_entity_reference_option_alter()`. It depends only on Drupal core; taxonomy, media, image and file behaviors light up when those modules and field types are in play. A JavaScript component kit (`Drupal.berUI` / `Drupal.berTags`) is exposed for building and extending widget UIs from other modules.

---

- Turn a taxonomy term reference field into a tag picker with folder-style drill-down of a nested vocabulary.
- Let editors reorder multi-value references by dragging tags or using the arrow keys, saving the order.
- Add a colored tag UI to any entity-reference field, including view-based selection handlers.
- Replace a long checkbox/select list on a list_string/list_integer field with the searchable Better Options widget.
- Show list-field and reference values as colored tags on the rendered page with the Better Tags formatter.
- Inherit the widget's tag colors on the display formatter, or configure independent formatter colors.
- Link rendered reference tags to the referenced entity's canonical page.
- Give a media reference field a thumbnail-tile widget that searches and sorts the media library.
- Upload files straight into a media field, auto-detecting the media type from the file extension.
- Accept remote/oEmbed video URLs in a media field, validated by each media type's own source.
- Replace core's file/image upload widget with a drag-and-drop dropzone that chunk-uploads large files with per-file progress.
- Swap the file/image "+" to a File Browser that picks from existing files with search, sort, type filter, grid/list view and paging.
- Restrict a file browser to only the current user's own uploads (private-file fields always behave this way).
- Cap a multi-value field's selections so the "+" disables at the cardinality limit and returns when a tag is removed.
- Offer inline quick-create ("+ New ...") so editors add and pick a new term or node in one step, with a bundle chooser when several are allowed.
- Warn on required-but-empty reference fields with a red label and inline message on submit.
- Highlight refused references (entities that cannot be referenced) with a red border after a failed save.
- Add search, name/date sort, a type/status filter, glossary letter-grouping and parent-terms-first grouping to the pick popover.
- Show rich tooltips on options and picked tags (hierarchy, type, id, size, usage, publication status, description).
- Add a `better_entity_reference` or `better_options` element to a custom form to reuse the whole tag UI.
- Override the staging directory used for chunked uploads via `$settings['better_entity_reference_staging_directory']` in settings.php.
- Scale the entire widget UI up or down by setting the `--ber-scale` CSS variable in a theme.
- Recolor or add file-type categories in the upload widgets via `hook_better_entity_reference_file_types_alter()`.
- Alter or add per-file detail fields (alt, title, description) via `hook_better_entity_reference_upload_details_alter()`.
- Build a demonstration site of every widget by applying the shipped `demo_content` recipe, or install the simplytest submodule on a sandbox.
- Compose or extend widget popovers from your own module's JavaScript using the `Drupal.berUI`/`Drupal.berTags` kit and its `ber-ui:*` events.
