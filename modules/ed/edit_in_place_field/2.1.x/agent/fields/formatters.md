# Field formatters (inline editing)

Four formatters replace a field's display with an inline-editable control. Set one on an entity's
**Manage display** (`admin/structure/types/manage/<bundle>/display`, any fieldable entity's view
display, or a View field). Each extends the equivalent core formatter, so for users **without** the
`edit in place field editing permission` permission it renders exactly like that core formatter
(read-only) — the editing form is only built when the current user has the permission.

| Formatter id | Label | Field types | Extends | Config schema |
|---|---|---|---|---|
| `edit_in_place_field_text` | Edit in place | `string`, `uri` | `StringFormatter` | `field.formatter.settings.edit_in_place_field_text` (= core string settings) |
| `edit_in_place_field_long_text` | Edit in place | `string_long`, `email` | `BasicStringFormatter` | `field.formatter.settings.edit_in_place_field_long_text` (empty mapping) |
| `edit_in_place_field_entity_reference` | Edit in place | `entity_reference` | `EntityReferenceLabelFormatter` | `field.formatter.settings.edit_in_place_field_entity_reference` |
| `edit_in_place_field_reference_with_parent` | Edit in place filtered by parent | `entity_reference` | `EntityReferenceLabelFormatter` | `field.formatter.settings.edit_in_place_field_reference_with_parent` |

## Text and long-text

No extra settings beyond the inherited string-formatter ones (e.g. `link_to_entity` on
`edit_in_place_field_text`). The inline widget is a `textfield` (`edit_in_place_field_text`) or a
`textarea` (`edit_in_place_field_long_text`), one input per value: fixed-cardinality fields get one
input per delta; unlimited-cardinality (`-1`) fields get one input per existing value **plus** a
trailing empty input to append a new value. On save, empty / whitespace-only values are removed
before writing (`EditInPlaceStringForm::processResponse()`).

## Entity reference (`edit_in_place_field_entity_reference`)

The select options come from the field's own entity-reference **handler settings**
(`EditInPlaceFieldReferenceFormatter::viewElements()`):

- `target_bundles` handler → all entities of those bundles, queried with `->accessCheck(TRUE)` and
  sorted by the label key.
- a `view` handler → the module runs that View (`Views::getView(...)->execute()`) and uses its result
  rows as options.

| Setting key | Meaning |
|---|---|
| `label_substitution` | Machine name of a field on the *referenced* entity to display instead of its label — applied in the select options and in the re-rendered output. |

The widget is a core `select`, or a **`select2`** element if the Select2 module is enabled; the
**Chosen** module, if present, is applied by `js/edit-in-place-field.js`. Cardinality `1` renders a
single-select; any other cardinality renders a multi-select.

## Entity reference filtered by parent (`edit_in_place_field_reference_with_parent`)

For hierarchical reference targets that themselves have a `parent` entity-reference field. The host
entity's `reference_parent_field_name` field supplies the set of parent ids; the widget then renders
**one select per parent**, each listing only the children whose `parent` target_id equals that parent
(`EditInPlaceFieldReferenceWithParentFormatter::getSelectableEntitiesList()` queries
`->condition('parent', $parent_id, '=')->accessCheck(TRUE)`).

| Setting key | Meaning |
|---|---|
| `reference_parent_field_name` (required) | Field on the *host* entity whose referenced entities are the "parents" used to group and filter the children. |
| `label_substitution` | Field to display instead of a child entity's label. |
| `parent_label_substitution` | Field to display instead of a parent entity's label (used as the group heading). |

## Enable a formatter from code

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_subtitle', [
    'type' => 'edit_in_place_field_text',
    'settings' => [],
  ])->save();
```

Then grant `edit in place field editing permission` to the roles that should edit inline; every other
role continues to see the field's normal, read-only core rendering. See
[../api/forms.md](../api/forms.md) for how a save is actually processed.
