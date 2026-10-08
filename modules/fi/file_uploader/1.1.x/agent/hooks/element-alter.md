# Hooks

## `hook_file_uploader_element_alter(&$element, &$settings, $form_state)`

Documented in `file_uploader.api.php`. Invoked from `FileUploader::processFileUploader()` as **both**
a module alter and a theme alter (module implementations run first, then the active theme's):

```php
\Drupal::moduleHandler()->alter('file_uploader_element', $element, $settings, $form_state);
\Drupal::theme()->alter('file_uploader_element', $element, $settings, $form_state);
```

- `$element` — the render array (attributes, attached libraries, `#value`, etc.).
- `$settings` — the array that becomes `drupalSettings.file_uploader[<id>]`
  (`provider`, `name`, `options` incl. `xhr` + `validators`, `values`). Alter `options.instance`,
  `options.plugin`, previews in `values`, etc.
- `$form_state` — the current `FormStateInterface`.

Example (from `file_uploader.api.php`): auto-start uploads and use an image style on existing
previews.

```php
function mymodule_file_uploader_element_alter(array &$element, array &$settings, FormStateInterface $form_state): void {
  $settings['options']['instance']['autoProceed'] = TRUE;
  if ($element['#name'] === 'field_image') {
    foreach ($settings['values'] as &$value) {
      $value['url'] = ImageStyle::load('large')->buildUrl(File::load($value['fid'])->getFileUri());
    }
  }
}
```

Implement the same signature in a theme's `.theme` file (`THEME_file_uploader_element_alter`) to
adjust it per theme.

## Hooks the module implements (for reference)

- `hook_theme()` — registers the `file_uploader` render-element theme hook.
- `hook_theme_suggestions_file_uploader()` — adds the suggestion `file_uploader__<#upload_provider>`,
  letting an integration/theme ship `file-uploader--<provider>.html.twig`.

See [../theme/file-uploader.md](../theme/file-uploader.md) for the template details.
