# Hooks

## hook_block_field_block_field_selection_info_alter(&$definitions)
Alter the discovered `BlockFieldSelection` plugin definitions (add, remove, or change the
selection strategies a Block field can use). Registered via the plugin manager's
`alterInfo('block_field_block_field_selection_info')`.

```php
function my_module_block_field_block_field_selection_info_alter(array &$definitions) {
  // e.g. remove the broad "categories" handler:
  unset($definitions['categories']);
}
```

Beyond this, filtering which blocks appear is normally done with core block APIs
(`hook_block_alter()`) or by writing a custom `BlockFieldSelection` plugin — see
[../plugins/block-field-selection.md](../plugins/block-field-selection.md).
