The DropzoneJS entity browser widget submodule exposes DropzoneJS as an Entity Browser widget, letting editors drag-and-drop files (and optionally create media entities) directly inside an Entity Browser.

---

This submodule of DropzoneJS bridges the `dropzonejs` upload element to the Entity Browser framework by providing `EntityBrowserWidget` plugins. The base `dropzonejs` widget uploads dropped files, saves them as permanent Drupal `file` entities, and selects them into the browser; two subclasses extend it to create Media entities (`dropzonejs_media_entity`) and to additionally show an inline entity form for editing metadata before selection (`dropzonejs_media_entity_inline_entity_form`). Each widget has a configuration form covering upload location (token-aware), drop-zone text, maximum file size, allowed extensions and full client-side resize options (width, height, quality, resize/thumbnail method). An optional "auto-select" mode submits the selection automatically via AJAX as soon as the upload finishes. It requires the parent `dropzonejs` module, core `file`, and `entity_browser`. Widget settings are stored in the Entity Browser config entity and validated on save. It is the standard way to plug modern drag-and-drop uploads into media reference fields that use Entity Browser.

---

- Add a drag-and-drop upload widget to any Entity Browser.
- Let editors upload files straight into a media reference field.
- Create Media entities from dropped files without leaving the browser.
- Edit media metadata inline via the inline-entity-form widget before selecting.
- Auto-select uploaded entities the moment the upload completes.
- Set a token-aware upload destination like `public://[date:custom:Y]-[date:custom:m]`.
- Restrict allowed file extensions per widget configuration.
- Cap the maximum upload size (in MB) per widget.
- Customize the drop-zone prompt text shown to editors.
- Enable client-side image resizing before upload to save bandwidth.
- Configure resize width, height and quality per widget.
- Choose contain vs crop for resizing and thumbnail generation.
- Bind a specific media type to the media-entity widget.
- Inherit file settings (size/extensions) from an existing configuration.
- Pick a form mode for the inline metadata editing step.
- Respect a reference field's cardinality when limiting uploaded files.
- Enforce upload validators passed in through the Entity Browser widget context.
- Replace a stock Entity Browser upload widget with Dropzone in exported config.
- Provide bulk multi-file media creation in one editorial step.
- React to media-entity-create events fired during widget submission.
- Disable the browser's submit button until uploads finish (bundled JS).
- Give content authors image previews while staging uploads.
- Build a reusable media library browser powered by drag-and-drop.
