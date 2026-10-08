<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete widget with mixed matching (autocomplete_mixed_matching) — agent index

Entity reference autocomplete that returns **STARTS_WITH matches first**, then fills the remaining
suggestion slots with **CONTAINS matches**. Version **1.1.0**. Core `^10 || ^11`. Declares
`php: 8.1`. License GPL-2.0-or-later. No dependencies, no permissions, no routes, no config entity.

## What it actually is (two parts)

1. **Field widget** `MixedMatchingAutocompleteWidget`
   (`src/Plugin/Field/FieldWidget/MixedMatchingAutocompleteWidget.php`), plugin id
   `autocomplete_mixed_matching`, label "Autocomplete, mixed matching", for `entity_reference`
   fields. Extends core `EntityReferenceAutocompleteWidget`. In `formElement()` it forces
   `#selection_settings['match_operator'] = 'STARTS_WITH'` and adds
   `#selection_settings['fallback_match_operator'] = 'CONTAINS'`. It removes the `match_operator`
   choice from the widget settings form (`settingsForm`, `defaultSettings`, `settingsSummary`) — the
   operators are fixed.

2. **Service decorator** `AdvancedEntityAutocompleteMatcher`
   (`src/Service/AdvancedEntityAutocompleteMatcher.php`), declared in
   `autocomplete_mixed_matching.services.yml` as `decorates: entity.autocomplete_matcher`. It
   replaces core's `EntityAutocompleteMatcher` site-wide but only changes behaviour when the
   selection settings contain `fallback_match_operator` — i.e. only for this module's widget.

## The matching mechanism

`AdvancedEntityAutocompleteMatcher::getEntityLabelsById()`:
- Runs the primary operator (`match_operator`, default `CONTAINS` if unset; `STARTS_WITH` as set by
  the widget) via the selection handler: `$handler->getReferenceableEntities($string, $op, $limit)`.
- If the result count is **>= match_limit** (default 10), returns it as-is.
- Otherwise, if a `fallback_match_operator` is present, runs a **second** query with that operator,
  merges the two result sets keyed by entity id (`+=`, so primary/prefix matches win and dups drop),
  and `array_slice(..., $limit, TRUE)` to cap at the limit.

All actual matching, sorting, and access filtering are delegated to the **core entity reference
selection handler**. The module writes no SQL and does not alter the entity query.

## Security-relevant facts (for reasoning, not disclosure)

- The typed string is passed to core's `getReferenceableEntities()` → core builds a **parameterized**
  entity query with proper `LIKE`/escaping. No raw string concatenation, no SQLi.
- The match operator values are **fixed constants** (`STARTS_WITH` / `CONTAINS`) from module code,
  never user input.
- **Access filtering is preserved** — suggestions come from the access-checked core selection
  handler; the module does not disable or bypass it.

## Config / schema

`provides_config_schema: true` — `config/schema/autocomplete_mixed_matching.widget.schema.yml`
defines `field.widget.settings.autocomplete_mixed_matching` (`match_limit`, `size`, `placeholder`).

## How to use

Manage form display of any entity type/bundle → pick "Autocomplete, mixed matching" for an
entity reference field. See `agent/fields/mixed-matching-widget.md` for details.

## Performance note

The CONTAINS fallback uses a **leading wildcard** and cannot use a normal index. On large reference
targets the substring half is the expensive half — benchmark on production-sized data.
