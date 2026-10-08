<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Export an Entity Reference Revisions (Paragraphs) field

## Steps (Views UI)

1. Have an `entity_reference_revisions` field (e.g. a Paragraphs field) and a **REST Export** view.
2. *Add field* → choose the field's **(serializable)** variant (handler `field_export`, already
   provided by rest_views for ERR fields).
3. Set its **Formatter** to the entity reference revisions **Export**
   (`entity_reference_revisions_export`).
4. Save.

The referenced revisioned entities serialize as a nested structure (an array of objects for a
multi-value field), like the standard `entity_reference_export` but for ERR/Paragraphs.

## Config shape

```yaml
# views.view.<id> -> display.<d>.display_options.fields.<field>
plugin_id: field_export                        # serializable handler (required)
type: entity_reference_revisions_export        # this submodule's formatter
```

## In code

```php
use Drupal\views\Entity\View;
$view = View::load('page_feed');
$display = $view->get('display');
$display['default']['display_options']['fields']['field_paragraphs'] = [
  'id' => 'field_paragraphs', 'table' => 'node__field_paragraphs', 'field' => 'field_paragraphs',
  'plugin_id' => 'field_export',
  'type' => 'entity_reference_revisions_export',
  'entity_type' => 'node', 'entity_field' => 'field_paragraphs',
];
$view->set('display', $display)->save();
```

## Nesting deeper

The formatter extends `EntityReferenceExportFormatter`, so it exports the referenced entity
using its display. For deeply nested paragraph data, give the paragraph type a **display mode**
whose own fields use REST Views export formatters, then reference that mode. See the parent
module doc and the project's issue links for the nested-display pattern.
