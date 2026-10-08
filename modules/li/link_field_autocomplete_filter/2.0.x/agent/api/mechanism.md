<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

Everything is in `link_field_autocomplete_filter.module` (hooks + two helpers) plus one config
schema. No service, plugin, or class.

## The settings form (per Link field instance)

`hook_form_field_config_edit_form_alter()` runs on every field instance edit form but returns
early unless `$entity->getType() === 'link'`. For link fields it adds an **"Autocomplete
Filter"** fieldset with:

- `negate` — radios: `0` *Include the selected below*, `1` *Exclude the selected below*
  (default value taken from the existing `negate` third-party setting).
- `allowed_content_types` — checkboxes of all node types
  (`_link_field_autocomplete_content_types_options()` → `NodeType::loadMultiple()`).

These are bound to `$form['third_party_settings']['link_field_autocomplete_filter']`, so core's
field-config form machinery saves them as third-party settings automatically.

## Filtering the widget

`hook_field_widget_single_element_form_alter()`:

1. returns unless `$context['widget'] instanceof \Drupal\link\Plugin\Field\FieldWidget\LinkWidget`;
2. reads `allowed_content_types` from the field definition's third-party settings and
   `$bundles = array_filter($settings)` (drop unchecked);
3. only acts if `count($bundles) > 0` (empty ⇒ all types allowed);
4. if `negate == '1'`, inverts the set:
   `$bundles = array_diff_key(all_type_options, $bundles)`;
5. sets on the `uri` element:
   - `#selection_handler = 'default:node'`
   - `#selection_settings = ['target_bundles' => $bundles]`
   so core's entity-autocomplete only suggests nodes of those bundles;
6. appends `_link_field_autocomplete_filter_validate_widget` to `#element_validate`.

## Validation

`_link_field_autocomplete_filter_validate_widget()` extracts the entity id from the autocomplete
input (`EntityAutocomplete::extractEntityIdFromAutocompleteInput`). If it resolves to a node
whose `getType()` is **not** in `target_bundles`, it calls
`$form_state->setError($element, 'This node: %id (type %type) cannot be referenced.')`. Manually
typed external URLs (no entity id) are unaffected. This catches values that were valid before the
allowed list was narrowed.

## Consequences an agent should know

- The whole feature keys off two third-party settings on the field instance; there is no global
  config and no permission.
- Filtering only applies to the core `LinkWidget`; other widgets are ignored.
- Only **nodes** are ever suggested/validated (`default:node`).
