# The `file_uploader` render element + XHR endpoint

`Drupal\file_uploader\Element\FileUploader` (`@FormElement("file_uploader")`) extends core
`ManagedFile`. Use it as a form element, or let `FileUploaderWidgetBase` build it for a file field.
It renders a `<div class="file-uploader …">` that a client-side uploader binds to, and uploads go
to the module's XHR endpoint which saves each file as a managed file (returning its `fid`).

## Element properties (`getInfo()`)

| Property | Default | Purpose |
|---|---|---|
| `#input` | `TRUE` | inherited from `ManagedFile` |
| `#multiple` | `FALSE` | multi-file (set from cardinality by the widget) |
| `#extended` | `TRUE` | managed-file extended value shape |
| `#upload_provider` | `NULL` | integration id; picks the `<provider>/widget` library, CSS class and theme suggestion |
| `#upload_options` | `[]` | arbitrary options passed to the JS uploader (merged into `drupalSettings … options`) |
| `#upload_validators` | `[]` | core file validators applied server-side on save |
| `#upload_location` | `NULL` | destination stream wrapper URI (e.g. `public://…`) |
| `#process` | `[processFileUploader]` | see below |
| `#element_validate` | `[validateManagedFile]` | explodes the space-joined `fids` hidden value, then calls parent |
| `#value_callback` | `[valueCallback]` | inherited from `ManagedFile` |
| `#theme` | `file_uploader` | see [theme/file-uploader.md](../theme/file-uploader.md) |

## `processFileUploader()` — what happens at render

1. Attaches library `"{$element['#upload_provider']}/widget"` and sets the wrapper `id` + CSS classes
   (`Html::cleanCssIdentifier($provider)` and `file-uploader-single|multiple` by `#cardinality`).
2. Serializes `['#name', '#upload_location', '#upload_validators']` into `$options`, derives
   `$key = Crypt::hmacBase64($options, \Drupal::csrfToken()->get())`, and **persists** it:
   `\Drupal::keyValue('file_uploader')->set($key, $options)`.
3. Builds the endpoint URL `Url::fromRoute('file_uploader.xhr')` with query
   `token = \Drupal::csrfToken()->get('file-uploader/upload')` and `key = $key`.
4. Loads existing `#value['fids']` into a `values` list (`fid/name/url/size/type`) and writes a hidden
   `fids` sub-element (space-joined fids).
5. Reads the extension/size limits from either `file_validate_extensions`/`file_validate_size` (D9/D10
   array style) or `FileExtension`/`FileSizeLimit` (D10.2+ attribute-validator style) and publishes
   `drupalSettings.file_uploader[<id>]` = `{provider, name, options:{…#upload_options, xhr, validators:{limit,extensions,filesize}}, values}`.
6. Invokes `hook_file_uploader_element_alter()` (module then theme) — see [hooks/element-alter.md](../hooks/element-alter.md).

## XHR endpoint

Route `file_uploader.xhr` — `file_uploader.routing.yml`:

```yaml
path: "/file-uploader/upload"
defaults:   { _controller: Drupal\file_uploader\Controller\FileUploaderController::upload }
requirements:
  _custom_access: Drupal\file_uploader\Controller\FileUploaderController::access
  _csrf_token: "TRUE"
```

Access (`FileUploaderController::access`) is granted only when the request carries an uploaded `file`
AND a `?key=` whose key-value entry unserializes (`allowed_classes => FALSE`) to an array containing
`#name` and `#upload_location`. Combined with `_csrf_token: "TRUE"` (validates `?token=` against the
session), the endpoint can only be driven from a legitimately-rendered element in the same session.

`upload()` reloads the stored options by `key`, re-injects the file as `files[<#name>]`, calls
`FileSystemInterface::prepareDirectory($upload_location, CREATE_DIRECTORY)`, then
`file_save_upload($name, $upload_validators, $upload_location)`. The destination and the validators
are the ones stored at render time — not taken from the request. On success it returns
`new AjaxResponse(['value' => $file->id()])`; on failure it flushes error messages and returns them
with HTTP 400.

## Minimal element usage

```php
$form['asset'] = [
  '#type' => 'file_uploader',
  '#title' => $this->t('Asset'),
  '#upload_provider' => 'uppy',            // an installed integration
  '#upload_location' => 'public://assets',
  '#upload_validators' => ['file_validate_extensions' => ['png jpg jpeg gif']],
  '#cardinality' => 3,
];
```

The submitted value follows core `ManagedFile` (`fids`); the JS client posts each file to the `xhr`
URL and stores the returned `fid` into the hidden `fids` field.
