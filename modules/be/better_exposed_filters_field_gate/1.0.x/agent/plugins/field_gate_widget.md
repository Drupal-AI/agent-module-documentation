<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bef_field_gate` BEF widget

Source: `src/Plugin/better_exposed_filters/filter/FieldGateCheckboxesRadioButtons.php`
(class `FieldGateCheckboxesRadioButtons`, attribute `#[FiltersWidget(id: 'bef_field_gate', title: 'Checkboxes/Radio Buttons with field gate')]`, `final`, extends BEF `RadioButtons`).
Hook class: `src/Hook/BetterExposedFiltersFieldGateHooks.php`.
Config schema: `config/schema/better_exposed_filters_field_gate.views.schema.yml`.

## Install / enable

`drush en better_exposed_filters_field_gate -y`. Requires `better_exposed_filters` (Composer `drupal/better_exposed_filters:^7.0`) and core `taxonomy` (both auto-enabled as deps). No config to import; no settings page.

## Where it applies

`isApplicable($filter, $filter_options)` returns TRUE only when the parent `RadioButtons::isApplicable()` passes **and** the filter is a `Drupal\taxonomy\Plugin\views\filter\TaxonomyIndexTid`. So the widget is offered only for taxonomy-term exposed filters. `BetterExposedFiltersFieldGateHooks::alterDisplayOptions()` (implements `hook_better_exposed_filters_display_options_alter`) adds the `bef_field_gate` entry to the BEF widget dropdown for those filters, guarded by the same `TaxonomyIndexTid` check and the presence of `$options['bef']`.

## Configuration (per exposed filter, in the View)

1. Edit a View whose exposed form is Better Exposed Filters and which has an exposed taxonomy-term filter.
2. In that filter's BEF settings, pick widget **"Checkboxes/Radio Buttons with field gate"**.
3. Open the **Field gate** details section (`#type => details`, auto-open when already enabled).
4. Check **"Limit options by referenced boolean field"** (`field_gate_enabled`). This checkbox is `#disabled` when the vocabulary has no boolean term fields.
5. Select the **Boolean field** (`field_gate_boolean_field`); the select is shown/required via `#states` only when the enable checkbox is ticked.
6. Save the View.

`defaultConfiguration()` = parent BEF settings plus `field_gate_enabled => FALSE`, `field_gate_boolean_field => ''`.

Config keys (schema type `better_exposed_filters.filter.bef_field_gate` extending `better_exposed_filters.filter.bef`):
- `field_gate_enabled` — boolean, "Limit options by referenced boolean field".
- `field_gate_boolean_field` — string, the term boolean field machine name.

## Validation

`validateConfigurationForm()`: if enabled with no field → error "Select a boolean field to enable field gating."; if enabled with a field not in `getBooleanFieldOptions()` → error "The selected field is not a valid boolean field for this taxonomy vocabulary." `submitConfigurationForm()` casts `field_gate_enabled` to bool and stores the selected field.

## How option filtering works at render

`exposedFormAlter(&$form, $form_state)`:
- Calls parent first; returns early if gating is disabled or no field is set.
- Resolves the exposed identifier (`group_info['identifier']` when the filter is grouped, else `expose['identifier']`), then filters `$form[$id.'_wrapper'][$id]['#options']` or `$form[$id]['#options']`.

Helper methods:
- `getBooleanFieldOptions()` — reads `entity_field.manager->getFieldDefinitions('taxonomy_term', <vid>)`, keeps only `FieldConfigInterface` definitions whose storage type is `boolean`, keyed by field name → label.
- `getVocabularyId()` — `$this->handler->options['vid']` (the filter's configured vocabulary), or NULL.
- `getAllowedTermIds()` — entity query on `taxonomy_term` with **`accessCheck(TRUE)`**, `condition('vid', <vid>)`, `condition(<boolean field>, 1)`; returns matching TIDs as strings, or NULL if the vocabulary/field is invalid.
- `filterOptions()` / `preserveNonTermOptions()` — drop any option whose key is all-digits (a term ID) and not in the allowed set; **keep** non-numeric keys such as `All` / `- Any -`. An empty allowed set removes every numeric option but keeps the non-term ones.

## Scope / limitations (from source + README)

- Taxonomy-term filters only, checkboxes/radio widget only, and the gate field must be a boolean field on that vocabulary.
- Filtering affects **only the rendered option list** of the exposed form. It does not alter the Views query or add access control; a request can still submit any term ID and Views will evaluate it normally (README: "does not prevent users from manually entering query parameters for hidden term IDs"). Treat it as UI curation, not a data-access boundary. The allowed-term query itself honors entity access via `accessCheck(TRUE)`.
