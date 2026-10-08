<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline Entity Form hierarchy widget

## Install & enable

```bash
composer require drupal/inline_entity_form
drush en entity_reference_hierarchy_ief -y
```

Requires the `inline_entity_form` module (and the parent `entity_reference_hierarchy`).

## Widget — `inline_entity_form_hierarchy`

`src/Plugin/Field/FieldWidget/InlineEntityFormHierarchy.php`:

```php
/**
 * @FieldWidget(
 *   id = "inline_entity_form_hierarchy",
 *   label = @Translation("Inline entity form"),
 *   field_types = { "entity_reference_hierarchy", "entity_reference_hierarchy_revisions" },
 *   multiple_values = true
 * )
 */
class InlineEntityFormHierarchy extends InlineEntityFormComplex { ... }
```

Choose it on *Manage form display* for a hierarchy or revisions-hierarchy field. It behaves like
IEF's complex widget (add existing / create inline / edit / remove) plus a depth control per row.

### Adding depth per row — `formElement()`

Calls `parent::formElement()`, then pulls the IEF entities from
`$form_state->get(['inline_entity_form', $this->getIefId(), 'entities'])` and, for each, adds:

```php
$element['entities'][$key]['depth'] = [
  '#type' => 'textfield', '#size' => 3,
  '#title' => $this->t('Depth for row @number', ['@number' => $delta + 1]),
  '#title_display' => 'invisible',
  '#default_value' => !empty($items[$key]->depth) ? $items[$key]->depth : 0,
  '#weight' => 100,
  '#attributes' => ['class' => ['ief-entity-depth']],
];
```

It also sets `$element['entities']['#entity_reference_hierarchy_ief'] = TRUE` so the preprocess
hook knows to build the tree table.

### Saving depth — `massageFormValues()`

`InlineEntityFormComplex` returns the reference values without depth, so this override re-reads the
raw submitted values at `$form['#parents'] + [field_name]` with
`NestedArray::getValue($form_state->getValues(), $path)` and copies
`$field_values['entities'][$delta]['depth']` onto `$values[$delta]['depth']` for each delta. That
is what persists the depth column.

## The IEF table — `hook_preprocess_inline_entity_form_entity_table()`

In `entity_reference_hierarchy_ief.module`. Runs only when `#entity_reference_hierarchy_ief` is set
**and** the inline-form handler's `isTableDragEnabled($form)` is TRUE:

- appends a **Depth** header cell (class `ief-depth-header`);
- for each child row, injects `#theme => 'indentation'` sized to the row's `depth` (when > 0) and
  places the depth element into a Depth cell;
- sets the three tabledrag operations:

```php
$variables['table']['#tabledrag'] = [
  ['action' => 'order', 'relationship' => 'all',    'group' => 'ief-entity-delta'],
  ['action' => 'depth', 'relationship' => 'group',  'group' => 'ief-entity-depth'],
  ['action' => 'match', 'relationship' => 'parent', 'group' => 'ief-entity-delta'],
];
```

- attaches `entity_reference_hierarchy/tabledrag.relationship-all` (the parent module's library
  providing the `all` relationship).

So the IEF entity table becomes the same drag-and-drop tree as the plain widget, but each row is a
fully inline-editable entity.

## Notes

- No config schema of its own; it stores nothing beyond the parent field type's `depth` column.
- Depth capture depends on the raw submitted structure — if IEF tabledrag is disabled for the
  target entity type, the Depth column is not shown (the hook's `isTableDragEnabled` guard).
