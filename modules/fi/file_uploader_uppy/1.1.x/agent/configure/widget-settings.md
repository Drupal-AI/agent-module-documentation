<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the `file_uploader_uppy` widget

There is **no module settings page and no `configure` route**. All configuration lives on the
field's widget, edited at *Structure → Content types → (bundle) → Manage form display* (or the
equivalent form display for any entity that has a `file`/`image` field). Set the widget to
**"File uploader by Uppy"**, click the gear, and the settings below appear. Values are stored in the
form-display config entity under `content.<field>.settings.options.*` and validated by the schema
`field.widget.settings.file_uploader_uppy` (`config/schema/file_uploader_uppy.schema.yml`).

The widget accepts both `file` and `image` fields and is `multiple_values = TRUE`, so one widget
handles the whole field (all deltas) — Uppy's Dashboard shows the full queue. Cardinality, allowed
extensions and max file size come from the **field's own storage/instance settings** (the standard
File/Image field config), not from this widget; the widget's JS only mirrors them into Uppy's
client-side `restrictions` for a nicer UX. The authoritative check runs server-side in the parent
module (`file_save_upload()` with the field's `#upload_validators`), so those limits are enforced
regardless of what the browser does.

## Settings form fields → config keys

Defined in `FileUploaderUppyWidget::settingsForm()` / `defaultSettings()`
(`src/Plugin/Field/FieldWidget/FileUploaderUppyWidget.php`). All `options.plugin.*` keys map to
Uppy Dashboard/StatusBar/ThumbnailGenerator options; see `DOCUMENTATION_URL`
(`https://uppy.io/docs/uppy/#options`).

- `options.uploader.method` — string, only value **`xhr`** (label "Drupal"), inherited from
  `FileUploaderWidgetBase::uploadMethods()`. Selects Uppy's `@uppy/xhr-upload` posting to the
  parent's `/file-uploader/upload` endpoint.
- `options.instance.autoProceed` — bool, default `FALSE`. Start uploading as soon as files are added.
  (JS note: if both `autoProceed` and `autoOpenFileEditor` are on, `autoProceed` is forced off and
  `autoProceedImageEditor` is used instead — upload runs after the image editor is closed.)
- `options.plugin.showProgressDetails` — bool, default `FALSE`.
- `options.plugin.hideCancelButton` — bool, default `FALSE`.
- `options.plugin.hideProgressAfterFinish` — bool, default `FALSE`.
- `options.plugin.singleFileFullScreen` — bool, default `TRUE`. Enlarge/center a single file preview.
- `options.plugin.disableStatusBar` — bool, default `FALSE`.
- `options.plugin.disableInformer` — bool, default `FALSE` (toast notifications).
- `options.plugin.disableThumbnailGenerator` — bool, default `FALSE`.
- `options.plugin.waitForThumbnailsBeforeUpload` — bool, default `FALSE`.
- `options.plugin.thumbnailWidth` — integer, default `200`.
- `options.plugin.thumbnailHeight` — integer, default `200`.
- `options.plugin.enableImageEditor` — bool, default `FALSE`. Enables `@uppy/image-editor`
  (crop/rotate/zoom/flip) — **only for new uploads**; existing files cannot be re-edited.
- `options.plugin.autoOpenFileEditor` — bool, default `FALSE`. Only visible (`#states`) when
  `enableImageEditor` is checked; auto-opens the editor for images in a batch.
- `options.plugin.imageEditor.actions` — sequence (multi-select), default `[]` = all actions.
  Allowed values: `revert`, `rotate`, `granularRotate`, `flip`, `zoomIn`, `zoomOut`, `cropSquare`,
  `cropWidescreen`, `cropWidescreenVertical`. (`imageEditor.cropperOptions` exists in defaults but
  has no form control.)
- `options.plugin.theme` — string select, default `light`; values `light` | `dark` | `auto`
  (Dashboard theme).

## How a value is captured (client → server round trip)

`widget.js` (source `components/widget/widget.js`) builds the Uppy instance, uses `Dashboard`, and —
when `method === 'xhr'` — `.use(XHR, { endpoint: settings.options.xhr })`. On `upload-success` it
reads the saved file id from `response.body.value` and appends it to the hidden
`<input name="<field>[fids]">`; on `file-removed` it drops the id. On form submit,
`FileUploaderWidgetBase::massageFormValues()` turns the space-separated `fids` into
`[{target_id: fid}, …]` field values. The static `preRender()` in this widget also pushes a
`disabled` flag into `drupalSettings` when the element is disabled.

## Live checks

- Confirm the widget id is available: `ddev drush ev "var_dump(array_key_exists('file_uploader_uppy', \Drupal::service('plugin.manager.field.widget')->getDefinitions()));"`
- Inspect a form display's stored settings after configuring:
  `ddev drush config:get core.entity_form_display.node.<bundle>.default`.
