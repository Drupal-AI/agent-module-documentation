# Programmatic API — service, controller & alter hooks

## Service — `shs.widget_defaults`

`Drupal\shs\WidgetDefaults` (interface `WidgetDefaultsInterface`), constructed with
`@entity_type.manager`. It builds the "parent chain" the JS needs to pre-open the dropdowns for
an already-saved value.

```php
/** @var \Drupal\shs\WidgetDefaults $defaults */
$defaults = \Drupal::service('shs.widget_defaults');

// Empty widget: one level per field-cardinality slot, parent 0.
$parents = $defaults->getInitialParentDefaults('_none', $cardinality);

// For a saved term id: the ancestry so every level select is pre-selected.
$parents = $defaults->getParentDefaults($term_id, '_none', 'taxonomy_term', $cardinality);
```

## Controller / endpoint — `ShsController::getTermData()`

`\Drupal\shs\Controller\ShsController::getTermData($identifier, $bundle, $entity_id = 0)` backs
route `shs.term_data` (`/shs-term-data/{identifier}/{bundle}/{entity_id}`, permission
`access content`). It returns a `ShsCacheableJsonResponse` — one level of the taxonomy tree with
`tid`, `name`, `description__value`, `langcode`, `hasChildren`; it respects term publish status,
content translation, and adds `taxonomy_term:<tid>` cache tags. This is what the widget calls for
each level.

## Helper functions (`shs.module`)

- `shs_term_has_children($tid)` — TRUE if the term has (access-filtered) children; used to decide
  whether to render the next-level dropdown.
- `shs_term_load_all_parents($tid, $target_type = 'taxonomy_term')` — loads a **single** ancestry
  chain for a term (first parent only), so hierarchy is well-defined even for multi-parent terms.
- `shs_get_class_definitions($field_name, $context)` — the default map of Backbone model/view
  class names, after the class-definition alter hooks run.

## Alter hooks (`shs.api.php`)

**JS class definitions** — swap the Backbone model/view classes used to build a widget:

- `hook_shs_class_definitions_alter(array &$definitions, array $context)`
- `hook_shs_FIELDNAME_class_definitions_alter(array &$definitions, array $context)` — one field.

**JS settings** — tweak per-level labels, the empty-option label, animation speed, etc.:

- `hook_shs_js_settings_alter(array &$settings_shs, $bundle, $field_name)`
- `hook_shs_FIELDNAME_js_settings_alter(array &$settings_shs, $bundle, $field_name)`

```php
function mymodule_shs_field_regions_js_settings_alter(array &$settings_shs, $bundle, $field_name) {
  $settings_shs['labels'] = [FALSE, t('Country'), t('City')];
  $settings_shs['display']['animationSpeed'] = 100;
}
```

**Term data** — alter the (uncached) term list before it is returned, all / per-bundle / per-field:

- `hook_shs_term_data_alter(array &$data, array $context)`
- `hook_shs__bundle_BUNDLE_NAME__term_data_alter(...)`
- `hook_shs__field_IDENTIFIER__term_data_alter(...)`
  (`$context` = `bundle`, `identifier`, `parent` tid.)

**Term data response** — alter the JSON string sent to the browser (runs on **every** AJAX call):

- `hook_shs_term_data_response_alter(&$content, array $context)`
- `hook_shs__bundle_BUNDLE_NAME__term_data_response_alter(...)`
- `hook_shs__field_IDENTIFIER__term_data_response_alter(...)`

## Plugins you extend (core base classes, not new plugin types)

- Widget `options_shs` — `OptionsShsWidget extends OptionsSelectWidget`. Subclass to build a
  custom SHS variant (that is exactly what `shs_chosen` does).
- Formatter `entity_reference_shs` — `EntityReferenceShsFormatter extends EntityReferenceLabelFormatter`.
- Views filters `ShsTaxonomyIndexTid`, `ShsTaxonomyIndexTidDepth`, `SearchApiShsTaxonomyIndexTid`.

Note: SHS defines **no render element** (there is no `#type => 'shs'`). The widget takes the core
options `<select>` and rewrites it to a `textfield` carrying an `#shs` settings array and the
`shs-enabled` class + `shs/shs.form` library; the Backbone behavior enhances it in the browser.
