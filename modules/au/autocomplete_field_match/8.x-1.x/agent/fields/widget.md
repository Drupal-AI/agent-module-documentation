<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Autocomplete Field Match" widget

## Install & enable

```bash
composer require drupal/autocomplete_field_match
drush en autocomplete_field_match -y
```

Dependencies are core **`field`** and **`field_ui`** only. No sub-modules, no permissions of its
own, no Drush, no services, no hooks. The on-disk tag is **8.x-1.0-alpha6** (D8-era) but it runs on
D11 (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

## Enable it on a field

Applies to any **`entity_reference`** field (`field_types = { "entity_reference" }` on
`AutocompleteFieldMatchWidget`). UI path:
*Structure → (bundle) → Manage form display* → set the reference field's widget to
**Autocomplete Field Match** → click the gear to set the options below → *Update* → *Save*.

It extends core's `EntityReferenceAutocompleteWidget`, so all core autocomplete widget settings
(`match_operator`, `size`, `placeholder`, and the inherited `match_limit`) still apply on top of
the match-specific ones.

## Widget settings (`defaultSettings()`)

| Setting key | Default | Meaning |
|---|---|---|
| `autocomplete_field_match` | `[]` | The field(s) to match free text against, as `entity_type.field` strings (multi-select). Built by `getFieldNames()` / `getEntityReferenceFields()`, which list non-base fields of the target type and, for reference fields, the referenced type's fields (one level deep — nested reference fields are skipped). |
| `autocomplete_field_match_type_of_field` | `value` | Which field **property** to compare: `value`, `uri`, or `target_id`. Empty is treated as `value` (back-compat). |
| `afm_operator_and_or` | `or` | Conjunction when several match fields are set: `and` (value must appear in all) or `or` (any). |
| `afm_operator_where` | `=` | Comparison operator for the entity-query condition: `=`, `>`, `<`, `>=`, `<=`, `STARTS_WITH`, `CONTAINS`, `ENDS_WITH`. |
| `afm_operator_langcode` | `[]` | Langcode(s) to restrict matching to. Empty = all installed languages (from `getInstalledLanguages()`). |
| `match_operator` | `STARTS_WITH` | Core dropdown match operator (inherited). |
| `size` | `60` | Textfield size (inherited). |
| `placeholder` | `''` | Placeholder text (inherited). |

`settingsSummary()` prints the chosen match fields, field type, AND/OR operator, where-operator and
languages on the Manage-form-display summary line. There is **no** config schema for these keys
beyond the empty `field.widget.settings.autocomplete_field_match` mapping in
`config/schema/autocomplete_field_match.schema.yml`; they are stored inside the
`core.entity_form_display.<entity>.<bundle>.<mode>` config the widget belongs to.

### Example form-display config

```yaml
# core.entity_form_display.node.article.default
content:
  field_ref:
    type: autocomplete_field_match
    settings:
      match_operator: STARTS_WITH
      size: 60
      placeholder: ''
      autocomplete_field_match:
        - node.field_sku
      autocomplete_field_match_type_of_field: value
      afm_operator_and_or: or
      afm_operator_where: '='
      afm_operator_langcode: {  }
```

## How it works (mechanism, from source)

1. **`formElement()`** (widget) copies the field's `handler_settings` and adds the six `afm_*` /
   match settings into `#selection_settings`, then emits an element of `#type =>
   'autocomplete_field_match'` with `#target_type`, `#selection_handler`, `#maxlength => 1024`, etc.
   Autocreate is wired only when the selection handler allows it.
2. **`processEntityAutocomplete()`** (element) stores `#selection_settings` in the
   `autocomplete_field_match` keyvalue store under an HMAC key
   (`Crypt::hmacBase64($data, Settings::getHashSalt())`) and points the element at route
   `autocomplete_field_match.autocomplete` with `{target_type}`, `{selection_handler}`,
   `{selection_settings_key}`. The live dropdown is therefore signed and tamper-resistant, and is
   served by core `EntityAutocompleteController::handleAutocomplete()` (label matching through the
   selection handler, which enforces entity access) — the module adds nothing to the live suggest
   path.
3. **`validateEntityAutocomplete()`** (element, at form submit) is where the extra matching runs,
   and only as a **fallback**: for each typed value it first calls core
   `extractEntityIdFromAutocompleteInput()`. If that returns an id (the editor picked a dropdown
   item like `Label (123)`), core behaviour is used. If it returns NULL (free text), the input is
   run through `Xss::filter()` and passed to `getAutocompleteFieldMatch()`.
4. **`getAutocompleteFieldMatch()` → `fieldMatchQuery()`** builds
   `\Drupal::entityQuery($entity_type)->accessCheck(TRUE)->condition($field.$property, $input,
   $where, $langcode)` for the first configured field; `combineMatches()` runs the same for the
   remaining fields and merges (OR) or intersects (AND) the id sets. Exactly one match → that id is
   referenced. More than one → `$form_state->setError()` tells the editor to disambiguate via the
   dropdown. Zero → falls back to core `matchEntityByTitle()`.
5. The resolved id(s) are finally re-checked with the selection handler's
   `validateReferenceableEntities()` / `validateReferenceableNewEntities()` before being written to
   the field value.

## Route & permission

`autocomplete_field_match.autocomplete` at
`/autocomplete_field_match/{target_type}/{selection_handler}/{selection_settings_key}` requires
`_permission: 'access content'` and is a read-only GET typeahead. This mirrors core's own
entity-autocomplete route; the settings key is HMAC-signed and the selection handler enforces
entity access on the suggestions.

## Operating notes / caveats

- **One level deep only.** `getEntityReferenceFields()` deliberately drops nested entity-reference
  fields ("neverending rabbithole. execution timeout likely.") — you cannot match a field on a
  reference-of-a-reference.
- **AND with multiple entity types** relies on `array_intersect` of ids across queries; ids are not
  namespaced per entity type, so mixing target types under AND can behave unexpectedly. Prefer
  matching fields on a single target type.
- **Free-typed matching is validation-time**, so it does not populate the visible dropdown — the
  suggestion list is still core label matching. Editors get a match (or a disambiguation error)
  only after submitting.
- **Stale-release detail:** `AutocompleteFieldMatchController::create()` passes six constructor args
  to core's two-arg `EntityAutocompleteController::__construct()`; PHP ignores the extras, so it
  still instantiates. The alpha6 packaging is old but the widget/element/controller load on D11.
