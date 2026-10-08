# Formatter & theming

One formatter, `reference_value_formatter` (default for the field type).
`\Drupal\reference_value_pair\Plugin\Field\FieldFormatter\ReferenceValueFormatter` extends
`ReferenceValueFormatterBase`, which extends core `EntityReferenceFormatterBase`. Output per delta
is the referenced entity's **label** followed by the scalar **value** (not a full entity render).

## Settings (`field.formatter.settings.reference_value_formatter`)

| Key                       | Default | Meaning |
|---------------------------|---------|---------|
| `display_invalid_reference` | `TRUE`  | Still display the pair when the referenced entity is missing/deleted. |
| `invalid_reference_label`   | `''`    | Label shown in place of a deleted reference (empty = show value only). Field is only visible when `display_invalid_reference` is checked. |

`settingsSummary()` reports either the fallback label, "display value without label", or
"Show only pairs where reference is valid".

## Render pipeline

- `viewElements()` builds one render element per delta returned by `getEntitiesToView()`:
  `#theme => 'reference_value_pair_formatter'`, `#item`, `#entity`, `#label` (entity label, or the
  invalid-reference label when the entity is NULL). When an entity is present its cache tags are
  attached.
- `getEntitiesToView()` (base) loads each referenced entity, applies `getTranslationFromContext()`
  for display language, runs `checkAccess()` and attaches the access cacheability; **only deltas
  whose access is allowed are returned** — access-denied references are omitted from output.
- `prepareView()` (base) implements the invalid-reference fallback: when `display_invalid_reference`
  is on, unloadable items get `entity = NULL` and `_label = invalid_reference_label` so the value
  still renders.
- `needsEntityLoad()` skips loading for autocreate (new) entities.

## Theme

- Theme hook `reference_value_pair_formatter` (registered in `reference_value_pair_theme()`),
  variables: `item`, `entity`, `url`, `element`.
- Template `templates/reference-value-pair-formatter.html.twig` outputs `{{ label }} {{ value }}`
  (Twig auto-escaped). `template_preprocess_reference_value_pair_formatter()` sets
  `value = item.value` and `label = entity ? entity.label() : label`.
- Template suggestions via `reference_value_pair_theme_suggestions_reference_value_pair_formatter()`:
  `…__<field_type>`, `…__<field_name>`, `…__<entity_type>__<bundle>`,
  `…__<entity_type>__<field_name>`, `…__<entity_type>__<field_name>__<bundle>`.

To customise markup, override the Twig template (optionally with one of the suggestions above);
there is no per-formatter link/URL option (the `url` variable is passed as NULL).
