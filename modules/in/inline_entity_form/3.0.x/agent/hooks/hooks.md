# Alter hooks

Defined in `inline_entity_form.api.php`. All three may also be implemented by **themes**
(via `hook_ID_alter` in a theme), not just modules.

### `hook_inline_entity_form_entity_form_alter(&$entity_form, &$form_state)`
Alter the embedded child entity form before it is shown in the widget. `$entity_form`
carries `#entity_type`, `#bundle`, `#entity`, etc.

```php
function mymodule_inline_entity_form_entity_form_alter(array &$entity_form, FormStateInterface &$form_state) {
  if ($entity_form['#entity_type'] === 'commerce_line_item') {
    $entity_form['quantity']['#description'] = t('New quantity description.');
  }
}
```

### `hook_inline_entity_form_reference_form_alter(&$reference_form, &$form_state)`
Alter the "Add existing" autocomplete form (has an `entity_id` entity_autocomplete field).

### `hook_inline_entity_form_table_fields_alter(&$fields, $context)`
Add / remove / reweight columns in the IEF table. `$context` keys: `parent_entity_type`,
`parent_bundle`, `field_name`, `entity_type`, `allowed_bundles`. Each field is an array
with `type` (`label` | `field` | `callback`), `label`, `weight`.

```php
function mymodule_inline_entity_form_table_fields_alter(array &$fields, array $context) {
  if ($context['entity_type'] === 'commerce_product_variation') {
    $fields['field_category'] = ['type' => 'field', 'label' => t('Category'), 'weight' => 101];
  }
}
```

See `InlineFormInterface::getTableFields()` for the base column set.
