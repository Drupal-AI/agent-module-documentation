# Embed hooks

From `embed.api.php`:

### `hook_embed_type_plugins_alter(array &$plugins)`
Alter the discovered `EmbedType` plugin definitions (keyed by plugin id). Use to relabel or
adjust another module's embed types.
```php
function mymodule_embed_type_plugins_alter(array &$plugins) {
  if (isset($plugins['entity'])) {
    $plugins['entity']['label'] = 'Embed content';
  }
}
```

Also relevant (implemented by the module, useful to know when integrating):
- `embed_embed_button_presave()` — clears the CKEditor 5 plugin cache and invalidates the
  `library_info` cache tag when an embed button is saved.
- `embed_form_filter_format_edit_form_alter()` / `_add_form_alter()` — add validation
  ensuring a button's `required_filter_plugin_id` filter is enabled (CKEditor 4).
