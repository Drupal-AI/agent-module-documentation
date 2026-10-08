# The `webform_dropzonejs` element

The module contributes a Webform element (not a new plugin *type* — it plugs into webform's existing
`WebformElement` plugin type and core's render-element system). Two classes cooperate:

## WebformElement plugin — `Plugin\WebformElement\WebformDropzonejs`

```php
@WebformElement(
  id = "webform_dropzonejs",
  label = @Translation("DropzoneJS"),
  description = @Translation("Provides a form element for uploading and saving a file via dropzonejs."),
  category = @Translation("File upload elements"),
  states_wrapper = TRUE,
)
```

Extends `Drupal\webform\Plugin\WebformElement\WebformManagedFileBase`, so it inherits the standard
managed-file admin settings (multiple, required, file extensions, max filesize, upload
destination/`#upload_location`, etc.). In the webform UI it appears under **File upload elements** as
"DropzoneJS".

- `form(array $form, FormStateInterface $form_state)` — the element's *admin* configuration form. It
  calls `parent::form()` and then hides four managed-file options that do not apply to a
  drag-and-drop widget: `file/button`, `file/button__title`, `file/button__attributes`,
  `file/file_placeholder` (each set `#access = FALSE`).
- `getFileExtensions(?array $element = NULL)` — returns `$element['#file_extensions']` when the
  element sets one, else the site default `webform.settings` → `file.default_managed_file_extensions`.
  (This value is what the render element advertises to Dropzone as accepted extensions and passes to
  the filename-sanitize event; see [../api/upload-flow.md](../api/upload-flow.md).)
- `validateManagedFile(&$element, $form_state, &$complete_form)` — **overrides** the base method and
  performs the actual save: it copies each uploaded temporary file into `#upload_location` as a
  permanent `file` entity (`file.repository` `writeData(..., FileSystemInterface::EXISTS_RENAME)`),
  handles removal of previously-attached files via the `deleted_dropzone_files` request parameter,
  and sets the submission value to a single fid (single) or an array of fids (`#multiple`). Full
  mechanism in [../api/upload-flow.md](../api/upload-flow.md).

## Render (FormElement) element — `Element\WebformDropzonejs`

`@FormElement("webform_dropzonejs")`, extends `Drupal\dropzonejs\Element\DropzoneJs`. This is the
actual `#type => 'webform_dropzonejs'` render element.

- `getInfo()` — `#input = TRUE`, `#tree = TRUE`, `#process = [processDropzoneJs]`,
  `#pre_render = [preRenderDropzoneJs]`, `#theme = 'dropzonejs'`,
  `#theme_wrappers = ['form_element']`, attaches `dropzonejs/integration`.
- `preRenderDropzoneJs($element)` — computes `#max_files` from `#multiple` (unset ⇒ 1; `TRUE` ⇒
  unlimited/`NULL`; integer ⇒ that many), sets `#dropzone_description`, derives `#extensions` from
  `#upload_validators` (`file_validate_extensions[0]` or `FileExtension.extensions`), and
  `#max_filesize` (appends `M`), then defers to `parent::preRenderDropzoneJs`.
- `processDropzoneJs(&$element, $form_state, &$complete_form)` — attaches
  `webform_dropzonejs/integration`, builds `drupalSettings.webformDropzoneJs[#id]` with the list of
  already-uploaded `#default_value` files (id/path/name/size/accepted/is_image) and a `file_directory`
  string (built by string-replacing `private://` and `_sid_` in `#upload_location`), calls
  `parent::processDropzoneJs`, then unshifts `validateWebformDropzonejs` onto `#element_validate`.
- `validateWebformDropzonejs(&$element, $form_state)` — required-field check only: if `#required`
  and `#value['uploaded_files']` is empty, `WebformElementHelper::setRequiredError()`.
- `valueCallback(&$element, $input, $form_state)` — turns the submitted `uploaded_files` string into
  the `#value['uploaded_files']` array of `[path, filename]`. Detailed in
  [../api/upload-flow.md](../api/upload-flow.md).

## Element settings an agent sets (host webform YAML / element edit form)

Because it extends `WebformManagedFileBase`, the usual managed-file keys apply on the element:

| Key | Meaning |
|---|---|
| `#file_extensions` | Space-separated allowed extensions (falls back to site default). |
| `#multiple` | Unset/`FALSE` ⇒ one file; `TRUE` ⇒ unlimited; integer ⇒ that many. |
| `#max_filesize` | Max size in MB (rendered to Dropzone as `<n>M`). |
| `#required` | Enforced by `validateWebformDropzonejs`. |
| `#uri_scheme` / `#upload_location` | Destination stream wrapper the permanent files are written to (e.g. `private://webform/...` or `public://webform/...`). |
| `#default_value` | Array of existing fids re-shown in the Dropzone on edit. |

The button/placeholder sub-settings of the base managed-file element are hidden by `form()` and have
no effect here.
