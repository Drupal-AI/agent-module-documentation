# The `media_library` form element

Render element `Drupal\media_library_form_element\Element\MediaLibrary` (`#type =>
'media_library'`). Opens core's modal Media Library to select/add media and returns the
selected media entity IDs.

```php
$form['image'] = [
  '#type' => 'media_library',
  '#allowed_bundles' => ['image'],        // media type machine names allowed
  '#title' => $this->t('Upload your image'),
  '#default_value' => NULL,               // NULL, '1', or '2,3,1' (comma-separated media IDs)
  '#description' => $this->t('Upload or select an image.'),
  '#cardinality' => 1,                    // 1 = single; -1 = unlimited
];
```

## Key properties
- `#allowed_bundles` (array) — media type ids the picker may select/create. Empty = all.
- `#cardinality` (int) — `1` for single value, `-1` (or N) for multiple; multi-value shows
  remove buttons and drag weights.
- `#default_value` — media entity ID(s): `NULL`, a single id string, or comma-separated ids.
- Standard `#title`, `#description`, `#required`, `#attributes`, `#wrapper_attributes`.

## Return value
On submit the element value is the selected media entity ID(s) (single id or comma-separated
list, matching `#cardinality`). Load them with the entity type manager as needed.

## Notes
- Internally delegates to core's `media_library` opener via service
  `media_library.opener.form_element` (`Drupal\media_library_form_element\MediaLibraryFormElementOpener`).
- Access and available media types follow core Media Library configuration/permissions.
- With Webform installed, the same widget is available as a Webform element
  (`Drupal\media_library_form_element\Plugin\WebformElement\MediaLibrary`) — no code needed.
