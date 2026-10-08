<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a dependent (cascading) field

The child field is an **entity-reference** field whose *Reference method* (selection handler)
is set to **`dependent_fields_selection`**. Its options are supplied by a View that takes the
**parent field's value** as its first contextual argument.

## Prerequisites

1. **Views** enabled.
2. A **View** with an **Entity Reference** display listing the child's target entities, whose
   **first contextual filter (argument)** matches the parent value (e.g. filter child terms by
   parent tid; set the argument to *"Allow multiple values"* if the parent can be multi-value).
3. Parent + child fields on the same bundle. The child's form widget must be **Select list**
   or **Check boxes/radio buttons** — the **autocomplete widget is not supported**.

## Via the UI

1. Edit the **child** entity-reference field (Field settings /
   `/admin/structure/types/manage/<bundle>/fields/...`).
2. Under **Reference method**, choose **"Make field dependent using views"**.
3. Fill in:
   - **View used to select the entities** — pick the `view:display` (Entity Reference displays only).
   - **Parent field** — the field this one depends on.
   - **Reference parent by UUID instead of entity ID?** — tick only if your View's argument
     expects UUIDs (config portability).
   - **View arguments** — optional comma-separated extra args appended after the parent value.
4. Save. On *Manage form display*, make sure the child widget is **Select list** or
   **radios/checkboxes**.

## Where it is stored (child field_config)

```yaml
# field.field.<entity_type>.<bundle>.<field_name>
settings:
  handler: dependent_fields_selection
  handler_settings:
    dependent_fields_view:
      view_name: my_view
      display_name: entity_reference_1
      parent_field: field_parent
      reference_parent_by_uuid: false
      arguments: []          # optional extra view arguments
```

Read back:
```bash
drush cget field.field.node.article.field_child settings.handler
# dependent_fields_selection
drush cget field.field.node.article.field_child settings.handler_settings.dependent_fields_view.parent_field
```

## Scriptable (drush php:eval)

```php
use Drupal\field\Entity\FieldConfig;
$fc = FieldConfig::loadByName('node', 'article', 'field_child');
$fc->setSetting('handler', 'dependent_fields_selection');
$fc->setSetting('handler_settings', [
  'dependent_fields_view' => [
    'view_name' => 'my_view',
    'display_name' => 'entity_reference_1',
    'parent_field' => 'field_parent',
    'reference_parent_by_uuid' => FALSE,
    'arguments' => [],
  ],
]);
$fc->save();
```

## How the AJAX refresh works

- `dependent_fields_field_widget_single_element_form_alter()` scans the entity's fields; if a
  field declares this field as its `parent_field`, it attaches an AJAX handler
  (`event: change`, or `autocompleteclose` for autocomplete) to the **parent** widget and
  attaches the `dependent_fields/dependentField` library.
- On change, `ViewsSelection::updateDependentField()` re-runs the View with the new parent
  value (converted to UUIDs if configured) as the argument and rebuilds the child's `#options`.
- It sends an `UpdateOptionsCommand` (JS command `updateOptionsCommand`) to replace the
  child field's options — or a `ReplaceCommand` for the `select_tagify` widget. Multi-value
  fields stay multi-value even when they start with no options.

## Gotchas

- Autocomplete widgets do not get filtered options — use Select/Checkboxes/Radios.
- The View must actually accept the parent value as its first argument, or the child won't filter.
- No admin settings page, permissions, or Drush commands — everything is per-field config.
