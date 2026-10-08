# Hooks (crop.api.php)

One alter hook is documented in `crop.api.php`:

## `hook_crop_entity_provider_info_alter(array &$providers)`
Alter the discovered `CropEntityProvider` plugin definitions (keyed by machine name).
```php
function mymodule_crop_entity_provider_info_alter(array &$providers) {
  $providers['media']['label'] = t('Super fancy provider for media entity!');
}
```

## Other integration points (not in api.php, but useful)
- `crop` implements `hook_file_delete()` to delete orphaned crops when a file is deleted.
- `crop` implements `hook_file_url_alter()` to append a short crop hash (`?h=...`) to
  derivative URLs for cache-busting.
- `crop` implements `hook_form_media_type_edit_form_alter()` to add the "Crop configuration"
  fieldset (image field selection) to media types.
- `hook_theme()` registers the `crop_crop_summary` template (`crop-crop-summary.html.twig`),
  used to summarize a crop effect in image-style config.
