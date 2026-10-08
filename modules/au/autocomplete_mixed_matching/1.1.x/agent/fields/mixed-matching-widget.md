<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widget: "Autocomplete, mixed matching"

Plugin id: `autocomplete_mixed_matching`
Class: `Drupal\autocomplete_mixed_matching\Plugin\Field\FieldWidget\MixedMatchingAutocompleteWidget`
Applies to field type: `entity_reference`
Extends: `Drupal\Core\Field\Plugin\Field\FieldWidget\EntityReferenceAutocompleteWidget`

## Behaviour

Behaves like core's entity reference autocomplete widget, except the match operator is not
configurable and matching is a two-step fallback chain:

1. Query the selection handler with **STARTS_WITH** (prefix matches).
2. If fewer than the match limit are returned, query again with **CONTAINS** (substring matches) and
   append the new ones, de-duplicated by entity id, capped at the match limit.

Result: prefix matches on top, substring matches below, exact/leading match never buried.

## How it wires the operators

`formElement()` calls the parent, then sets on the autocomplete element:
```php
$elements['target_id']['#selection_settings']['match_operator'] = 'STARTS_WITH';
$elements['target_id']['#selection_settings']['fallback_match_operator'] = 'CONTAINS';
```
The `fallback_match_operator` key is only understood by this module's decorator of the
`entity.autocomplete_matcher` service (`AdvancedEntityAutocompleteMatcher`). Core's matcher ignores
unknown keys, so if the module is uninstalled the field degrades to plain STARTS_WITH rather than
breaking.

## Settings

Same settings as the core widget, minus the match-operator selector, which is removed in
`settingsForm()`, `defaultSettings()`, and `settingsSummary()`. Config schema
`field.widget.settings.autocomplete_mixed_matching` exposes `match_limit`, `size`, `placeholder`.

## Enabling it

Via UI: Structure → (entity type) → Manage form display → set the entity reference field's widget to
"Autocomplete, mixed matching".

Via Drush field:create (example from the module README):
```sh
drush field:create node recipe --field-name=field_other_tag --field-label="Other tag" \
  --field-type=entity_reference --field-widget=autocomplete_mixed_matching \
  --target-type=taxonomy_term --target-bundle=tags -y --cardinality=1
```

## Caveats

- The CONTAINS half uses a leading wildcard (`%term%`) and cannot use a normal index — benchmark on
  large targets.
- Matching, sorting, and access filtering are handled by the core selection handler; this widget
  only changes which operators are tried and in what order.
