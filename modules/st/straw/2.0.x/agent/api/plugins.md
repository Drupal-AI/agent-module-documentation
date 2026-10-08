<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Straw plugins, element & services

## `EntityReferenceSelection` — `StrawSelection`

`src/Plugin/EntityReferenceSelection/StrawSelection.php`, annotation `@EntityReferenceSelection`
id `straw`, label "Straw selection", group `straw`; extends core `TermSelection`. It overrides
match/referenceable-entity logic so autocomplete queries consider a term's **whole ancestry**,
and caches computed hierarchies (keyed by bundle + context) in the `straw` cache bin. This is
what you choose as the field's reference method.

## `FieldWidget` — `SuperTermReferenceAutocompleteWidget`

`src/Plugin/Field/FieldWidget/…`, `@FieldWidget` id
`super_term_reference_autocomplete_widget`, label "Autocomplete (Straw style)"; extends
`EntityReferenceAutocompleteWidget`. For entity-reference (taxonomy term) fields. It renders the
custom form element below instead of the plain entity autocomplete.

## `FormElement` — `SuperTermReferenceAutocomplete`

`src/Element/SuperTermReferenceAutocomplete.php`, `@FormElement`
`super_term_reference_autocomplete`; extends core `EntityAutocomplete`. Accepts an entity object
or the usual autocomplete value as `#default_value`, formats existing values with the `>>`
ancestry, and parses `Parent >> Child` input into a term path (creating missing terms when the
field allows it).

## Services

- `straw.new_term_storage` (`NewTermStorage`) — stages terms to be created from a typed `>>`
  path so parents/children are created in the right order and existing ancestors are reused.
- `cache.straw` — a dedicated cache bin (`straw`) for hierarchy lookups.

## Notes

- No plugin *type* is defined; these are implementations of core plugin types
  (EntityReferenceSelection, FieldWidget, FormElement).
- Nothing here is configured globally — behaviour is entirely driven by selecting the `straw`
  handler + the Straw widget on a field (see `configure/setup.md`).
