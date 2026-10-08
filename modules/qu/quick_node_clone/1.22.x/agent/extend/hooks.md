# Quick Node Clone hooks

From `quick_node_clone.api.php`. Both fire while building the clone, before the edit form is
shown — use them to post-process copied values.

- `hook_cloned_node_alter($new_node, $original_node)` — alter the cloned node entity
  (reset a field, change author, adjust dates, clear a unique value, etc.).
- `hook_cloned_node_paragraph_field_alter($new_paragraph, $field_name, $original_paragraph)`
  — alter a cloned Paragraph's field values as paragraphs are recursively duplicated.

```php
function my_module_cloned_node_alter($new_node, $original_node) {
  $new_node->set('field_event_date', NULL);   // force editor to pick a new date
}
```
