<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

From `merge_translations.api.php`.

## `hook_merge_translations_prepare_alter(array &$node_array)`

Invoked (via `moduleHandler->invokeAll()`) in `MergeTranslationsForm::addTranslation()` for each
source node just before its values are added as a translation on the target node. `$node_array` is the
source node's `toArray()` output; alter it in place to change what gets stored.

```php
/**
 * Implements hook_merge_translations_prepare_alter().
 */
function my_module_merge_translations_prepare_alter(array &$node_array) {
  // e.g. force a title, or strip a field you don't want copied into the translation.
  $node_array['title'][0]['value'] = 'Translated title';
  unset($node_array['field_internal_notes']);
}
```

Runs once per source node per merge (for each selected language row). There is no corresponding
"after" hook.
