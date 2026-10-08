<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Classic hierarchy widget

## Install & enable

```bash
composer require drupal/paragraphs drupal/entity_reference_revisions
drush en entity_reference_hierarchy_paragraphs -y
```

Requires `paragraphs`, plus the parent `entity_reference_hierarchy` and
`entity_reference_hierarchy_revisions` submodule (all in the `.info.yml` dependency list). Add an
`entity_reference_hierarchy_revisions` field targeting paragraphs, then set its form-display widget
to **Paragraphs Classic**.

## Widget — `entity_reference_hierarchy_paragraphs`

`src/Plugin/Field/FieldWidget/InlineParagraphsHierarchyWidget.php`:

```php
/**
 * @FieldWidget(
 *   id = "entity_reference_hierarchy_paragraphs",
 *   label = @Translation("Paragraphs Classic"),
 *   field_types = { "entity_reference_hierarchy_revisions" }
 * )
 */
class InlineParagraphsHierarchyWidget extends InlineParagraphsWidget {
  use EntityReferenceHierarchyWidgetTrait;   // from the parent module
  ...
}
```

- `formElement()` calls `parent::formElement()` (the standard Paragraphs inline form), then adds a
  `depth` textfield (`#size 3`, invisible title *"Depth for row N"*, default
  `isset($items[$delta]->depth) && $items[$delta]->depth !== '' ? $items[$delta]->depth : 0`).
- `formMultipleElements()` sets `$elements['#entity_reference_hierarchy_paragraphs'] = TRUE`.

It targets **only** `entity_reference_hierarchy_revisions` (Paragraphs stores target revisions), so
pair it with the revisions submodule's field type.

## The tree table — `hook_preprocess_field_multiple_value_form()`

In `entity_reference_hierarchy_paragraphs.module`, gated on `#entity_reference_hierarchy_paragraphs`
and a multi-value form. It mirrors the parent module's preprocess but is tuned for the Paragraphs
table layout:

- appends a **Depth** header;
- sorts rows with `_field_multiple_value_form_sort_helper`;
- gives the `depth` element a `{table_id}-delta-depth` class;
- sets the first cell to `width: auto; min-width: 30px` and, for depth > 0, replaces its content
  with a `#theme => 'indentation'` element;
- appends the depth field as a trailing Depth column and unsets the inline copy;
- sets the three tabledrag ops (`order`/`all`, `depth`/`group`, `match`/`parent` using
  `{table_id}-delta-order` and `{table_id}-delta-depth`);
- attaches `entity_reference_hierarchy/tabledrag.relationship-all`.

## Notes

- No config schema, routes, permissions or services of its own.
- Rendering the nested paragraphs uses the revisions submodule's
  `entity_reference_hierarchy_revisions_entity_view` (*Nested Rendered entity*) formatter.
- Because it extends the classic `InlineParagraphsWidget`, it does not add the experimental
  Paragraphs widget features — only the depth/tree column on top of the classic widget.
