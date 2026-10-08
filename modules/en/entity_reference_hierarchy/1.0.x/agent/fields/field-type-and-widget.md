<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, widget, and how depth becomes a tree

## Install & enable

```bash
composer require drupal/entity_reference_hierarchy
drush en entity_reference_hierarchy -y
```

No dependencies. Enabling exposes a new field type in the *Reference* category.

## The field type — `entity_reference_hierarchy`

`src/Plugin/Field/FieldType/EntityReferenceHierarchyItem.php` extends core's
`EntityReferenceItem` and mixes in `EntityReferenceHierarchyItemTrait`
(`src/Plugin/Field/FieldType/EntityReferenceHierarchyItemTrait.php`). Annotation:

- id `entity_reference_hierarchy`, category `reference`
- default_widget `entity_reference_hierarchy_autocomplete`
- default_formatter `entity_reference_label`
- list_class `\Drupal\entity_reference_hierarchy\EntityReferenceHierarchyFieldItemList`

The trait adds exactly **one** thing on top of a normal entity reference: a `depth` value.

- `schema()` calls `parent::schema()` (which gives `target_id`) and adds a `depth` column:
  `type => int, size => tiny, unsigned => TRUE`. So each stored reference row is
  `{ target_id, depth }`, plus the standard field `delta` (row order) that Drupal always stores.
- `propertyDefinitions()` adds a `depth` integer property labelled *Depth*.
- `setValue()` calls `parent::setValue()` then `$this->onChange('depth', FALSE)` so the depth
  property stays in sync when values are set programmatically.

There is **no `parent_id` column and no `weight` column**. "Weight" is the field delta; "parent"
is inferred from depth + order (see [../api/tree-outline.md](../api/tree-outline.md)).

Storage settings config schema `field.storage_settings.entity_reference_hierarchy` simply inherits
`field.storage_settings.entity_reference`, so target-type / target-bundle settings work like core.

## The widget — `entity_reference_hierarchy_autocomplete`

`src/Plugin/Field/FieldWidget/EntityReferenceHierarchyAutocompleteWidget.php` extends core
`EntityReferenceAutocompleteWidget` and mixes in `EntityReferenceHierarchyWidgetTrait`
(`.../EntityReferenceHierarchyWidgetTrait.php`):

- `formElement()` adds a small **`depth` textfield** (`#size => 3`, invisible title *"Depth for
  row N"*, default `$items[$delta]->depth` or `0`) to each reference row.
- `formMultipleElements()` sets `$elements['#entity_reference_hierarchy'] = TRUE` — the flag the
  preprocess hook looks for.

Pick it per field on *Manage form display*; it is the default widget for the field type.

## From flat rows to a drag-and-drop tree

The tabledrag tree is assembled entirely in `entity_reference_hierarchy.module`
`hook_preprocess_field_multiple_value_form()`, only when the element carries
`#entity_reference_hierarchy`:

1. It removes the leftover header colspan and appends a **Depth** header column.
2. Rows are sorted with core's `_field_multiple_value_form_sort_helper` (by `_weight`).
3. For each row it removes the drag-handle cell (for cleaner indentation), gives the `depth`
   element a `{table_id}-delta-depth` class, and — when `depth > 0` — prepends a
   `#theme => 'indentation'` element sized to the depth into the content cell.
4. It moves the `depth` field out of the content cell into its own trailing Depth column.
5. It attaches three tabledrag operations and the custom library:

```php
$variables['table']['#tabledrag'] = [
  ['action' => 'order',  'relationship' => 'all',    'group' => $order_class],
  ['action' => 'depth',  'relationship' => 'group',  'group' => $depth_class],
  ['action' => 'match',  'relationship' => 'parent', 'group' => $order_class],
];
$variables['table']['#attached']['library'][] = 'entity_reference_hierarchy/tabledrag.relationship-all';
```

The `relationship => 'all'` on the `order` action is not a core tabledrag relationship — it is
provided by `js/tabledrag.relationship-all.js` (library `tabledrag.relationship-all`, depends on
`core/tabledrag`), which lets dragging a row carry the whole subtree with it. The `depth` action
drives the hidden depth textfield as the row is indented/outdented; `match => parent` keeps a
dragged row attached to a valid parent.

The result is the familiar taxonomy/menu drag UI: indent to nest, drag to reorder, and the
Depth column reflects each row's level.

## Opening core formatters to the field

`hook_field_formatter_info_alter()` appends `entity_reference_hierarchy` (and
`entity_reference_revisions_hierarchy`) to the `field_types` list of every formatter that already
supports `entity_reference`. So any core entity_reference formatter (Label, Rendered entity,
Entity ID, …) is selectable on the field — the two *"with hierarchy"* formatters
([formatters.md](formatters.md)) are the ones that actually render the nesting.
