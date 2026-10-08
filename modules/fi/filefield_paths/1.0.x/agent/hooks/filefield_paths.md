# Hooks — `filefield_paths.api.php`

Two hooks let other modules extend the per-field settings form and the file-processing step.

## `hook_filefield_paths_field_settings(array $form)`

Add extra fields to the "File (Field) Path settings" section. Return an array keyed by setting
name; each value is `['title' => ..., 'form' => [ /* Form API elements */ ]]`. The module's own
**File path** and **File name** fields are provided this way. Each returned field automatically
gets the cleanup options (slashes / pathauto / transliterate) and, when Token is enabled, token
validation.

```php
function mymodule_filefield_paths_field_settings(array $form) {
  return [
    'file_path' => [
      'title' => 'File path',
      'form' => [
        'value' => [
          '#type' => 'textfield',
          '#title' => t('File path'),
          '#maxlength' => 512,
          '#default_value' => $form['settings']['file_directory'],
        ],
      ],
    ],
  ];
}
```

## `hook_filefield_paths_process_file(ContentEntityInterface $entity, FieldItemListInterface $field, array &$settings = [])`

Invoked while processing a field's uploaded files (respecting the field's `active_updating`
setting). Use it to run custom logic per referenced `File` — e.g. detect a newly attached file
by comparing against `$entity->original`, or apply extra transformations. `$settings` holds the
field's filefield_paths settings.

```php
function mymodule_filefield_paths_process_file(ContentEntityInterface $entity, FieldItemListInterface $field, array &$settings = []) {
  if (empty($settings['active_updating'])) {
    return;
  }
  foreach ($field->referencedEntities() as $file) {
    if ($file instanceof \Drupal\file\FileInterface) {
      // Custom processing for $file …
    }
  }
}
```

Both hooks can be implemented as procedural functions or as OOP `#[Hook]` methods; the module
ships `#[LegacyHook]` shims (`Hook\FileFieldPathsFieldSettingsLegacy`,
`Hook\FileFieldPathsProcessFileLegacy`) for the procedural forms.
