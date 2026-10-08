<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widget: ImageScanWidget (image_widget)

`Drupal\amazon_image_id_scan\Plugin\Field\FieldWidget\ImageScanWidget`
(`src/Plugin/Field/FieldWidget/ImageScanWidget.php`). Extends core
`Drupal\image\Plugin\Field\FieldWidget\ImageWidget`.

```php
/**
 * @FieldWidget(
 *   id = "image_widget",
 *   label = @Translation("Mi Widget Imagen"),
 *   field_types = { "image" },
 * )
 */
```

Select it on **Manage form display** for any `image` field. It behaves like the core image widget
plus a Rekognition validation step on upload.

## Widget settings — settingsForm() / defaultSettings()

`defaultSettings()` adds `config_id_scan => NULL` to the core image-widget defaults
(`progress_indicator`, `preview_image_style`). `settingsForm()` adds:

- `preview_image_style` — standard image-style select.
- **`config_id_scan`** — a select whose options are the numeric validation-profile ids from
  `amazon_image_id_scan.settings` → `rekognition_tab.tab_config` (each option label is the profile's
  `label`), plus a "no config" empty option. This is how a field widget is bound to a validation
  profile configured on the settings form (see [../config/settings.md](../config/settings.md)).

## formElement()

Calls the parent to build the standard managed-file/image element, then:

- Forces upload validators: `FileIsImage`, `FileImageDimensions` (when min/max resolution set),
  `FileExtension` (intersection of the field's extensions with the toolkit's supported extensions).
- Sets `#accept => 'image/*'` (mobile capture) and the usual alt/title/default-image properties.
- **Appends `$element['#element_validate'][] = [$this, 'validateScan']`** — the scan hook.

## validateScan(&$element, FormStateInterface $form_state)

Runs only when the triggering element name contains `upload_button` (i.e. during the AJAX upload
step, not on the final submit). For each uploaded `fid` in the field value:

1. Loads the `File` entity (`File::load($fid['fids'][0])`).
2. `$url = $file->createFileUrl(FALSE);` then `$image = file_get_contents($url);` — reads the
   just-uploaded managed file's own bytes via its file URL.
3. If a numeric `config_id_scan` is set, gets the `amazon_image_id_scan.rekognition` service and the
   profile config (`\Drupal::config('amazon_image_id_scan.settings')->get($id_config)`), then calls
   `Rekognition::document($image, $config_scan, $id_config)`.
4. If the service returns `['error' => …]`, calls `$form_state->setError($element, $response['error'])`
   — failing the upload with the profile's configured (admin-defined) message.

So the field is accepted only when the image passes the profile's positive-label, negative-label and
regex checks (see [../api/rekognition.md](../api/rekognition.md)). With no `config_id_scan` selected,
the widget behaves as a plain (core-like) image widget and performs no Rekognition call.

## Operational notes

- The Rekognition call happens synchronously inside form validation, so upload latency includes two
  AWS API round-trips (DetectLabels + DetectText). Each accepted-or-rejected upload consumes paid
  Rekognition quota.
- Validation is per configured field widget; different image fields can point at different profiles.
- The error passed to `setError()` is the profile's `error_description` string (or a default Spanish
  message); it is shown to the uploader as a standard form error.
