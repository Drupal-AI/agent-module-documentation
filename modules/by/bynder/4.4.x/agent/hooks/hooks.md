# Bynder alter hooks (`bynder.api.php`)

Bynder invites two `hook_*_alter` implementations.

## `hook_bynder_search_query_alter(array &$query, FormStateInterface $form_state, BynderSearch $widget)`

Alter the search query sent to the Bynder API before the `bynder_search` Entity Browser widget calls
`getMediaList()`. Use it to add custom filters (e.g. from extra exposed form fields).

```php
function mymodule_bynder_search_query_alter(array &$query, \Drupal\Core\Form\FormStateInterface $form_state, \Drupal\bynder\Plugin\EntityBrowser\Widget\BynderSearch $widget) {
  if ($value = $form_state->getValue(['filters', 'my_property'])) {
    $query['property_my_property'] = $value;
  }
}
```

## `hook_bynder_media_update_alter(MediaInterface $media, array $item, bool &$has_changed)`

Fires while a Bynder media entity's local copy is refreshed from remote metadata (`$item` = raw Bynder
metadata). Derive extra fields on `$media`; **set `$has_changed = TRUE`** if you modify it so the change is
saved.

```php
function mymodule_bynder_media_update_alter(\Drupal\media\MediaInterface $media, array $item, &$has_changed) {
  if (!empty($item['copyright']) && $media->hasField('field_copyright')) {
    $media->set('field_copyright', $item['copyright']);
    $has_changed = TRUE;
  }
}
```

No other hooks are defined by this module.
