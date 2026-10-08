# Field widget base — `FileUploaderWidgetBase`

`Drupal\file_uploader\Plugin\Field\FieldWidget\FileUploaderWidgetBase` extends core
`Drupal\file\Plugin\Field\FieldWidget\FileWidget` and implements `TrustedCallbackInterface`. It is
**not a usable widget on its own** — it has no `@FieldWidget` annotation. An integration module
subclasses it, adds the annotation (targeting `file`/`image` fields) and provides the matching
JS provider + `<provider>/widget` library. This is the primary way to build an integration.

## What the base provides

| Member | Purpose |
|---|---|
| `const DOCUMENTATION_URL` | `NULL` in the base; a subclass overrides it — rendered as a link in the settings form. |
| `uploadMethods()` (static) | Allowed upload methods; base returns `['xhr' => t('Drupal')]`. Override to add more. |
| `defaultSettings()` | Adds `options => ['instance' => [], 'plugin' => [], 'uploader' => ['method' => 'xhr']]` on top of `FileWidget` defaults. |
| `getSetting($key)` | For array settings, deep-merges the stored value over `defaultSettings()['options']` so new option keys always resolve. |
| `settingsForm()` | Renders the `DOCUMENTATION_URL` note plus an `options[uploader][method]` select from `uploadMethods()`. Subclasses add their own option fields under `options`. |
| `settingsSummary()` | Two lines: `Upload method: …` and `Progress indicator: File uploader`. |
| `formSingleElement()` | Builds the actual `#type => file_uploader` element (see below). |
| `process()` / `preRender()` | No-op hooks a subclass can override; `preRender` is the only trusted callback. |
| `massageFormValues()` | Maps `{fids: [...]}` back to field items `[['target_id' => $fid], …]`. |

## `formSingleElement()` — the element it builds

Ensures an item exists, calls `parent::formSingleElement()` to obtain core's `#upload_location`,
`#upload_validators`, `#cardinality`, `#required`, then normalises option values (numeric-string
`<= 1` treated as boolean) and returns:

```php
return [
  '#type' => 'file_uploader',
  '#title' => $this->fieldDefinition->getLabel(),
  '#description' => ['#theme' => 'file_upload_help', /* description, upload_validators, cardinality */],
  '#process' => [[static::class, 'process'], [FileUploader::class, 'processFileUploader']],
  '#pre_render' => [[static::class, 'preRender']],
  '#upload_options' => $options,                 // the widget's own settings
  '#upload_location' => $element['#upload_location'],
  '#upload_validators' => $element['#upload_validators'],
  '#cardinality' => $element['#cardinality'],
  '#multiple' => $element['#cardinality'] > 1,
  '#default_value' => ['fids' => array_column($items->getValue(), 'target_id')],
  '#required' => $element['#required'],
];
```

Note the `#upload_provider` is **not** set here — a concrete subclass is expected to set it (matching
its JS provider id) so the element attaches `<provider>/widget` and picks the right theme suggestion.

## Skeleton integration widget

```php
/**
 * @FieldWidget(
 *   id = "myuploader",
 *   label = @Translation("My uploader"),
 *   field_types = {"file", "image"},
 *   multiple_values = TRUE,
 * )
 */
class MyUploaderWidget extends FileUploaderWidgetBase {
  const DOCUMENTATION_URL = 'https://example.com/docs';

  protected function formSingleElement($items, $delta, array $element, array &$form, FormStateInterface $form_state): array {
    $element = parent::formSingleElement($items, $delta, $element, $form, $form_state);
    $element['#upload_provider'] = 'myuploader';   // matches window.DrupalFileUploader.myuploader
    return $element;
  }
}
```

The field's configured allowed extensions and max size flow through core into `#upload_validators`,
so they are enforced on the server when the XHR endpoint calls `file_save_upload()`.
