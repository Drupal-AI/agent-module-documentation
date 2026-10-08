# Taxonomy Formatter — formatter settings

Plugin: `src/Plugin/Field/FieldFormatter/TaxonomyTermReferenceFormatter.php`, id
`taxonomy_term_reference_formatter`, `field_types = {entity_reference}`. Extends
`EntityReferenceFormatterBase`.

## Settings (`defaultSettings()`)
| Key | Type | Default | Effect |
|---|---|---|---|
| `links_option` | checkbox/bool | `FALSE` | On → each term rendered as `$entity->toLink()`; off → escaped `$entity->label()`. |
| `separator_option` | textfield/string | `", "` | Joins terms; include leading/trailing spaces. Escaped with `Html::escape` before use. |
| `element_option` | select | `- None -` | HTML tag wrapping EACH term. Options: `- None -`, `span`, `h1`–`h5`, plus two mislabeled entries: option shown "h6" outputs `<strong>`, option shown "h7" outputs `<em>`. |
| `element_class` | textfield | `''` | Class on each term element; passed through `Html::cleanCssIdentifier()`. |
| `wrapper_option` | select | `- None -` | HTML tag wrapping the WHOLE list. Options: `- None -`, `div`, `span`, `h1`–`h5`, `p`, `strong`, `em`. |
| `wrapper_class` | textfield | `''` | Class on the wrapper element; via `Html::cleanCssIdentifier()`. |

## Rendering (`viewElements()`)
- Returns `[]` when there are no items.
- Builds `$formatted` by looping `getEntitiesToView($items, $langcode)`: `elementwrap[0] . (link |
  Html::escape(label)) . elementwrap[1] . separator`, then trims the trailing separator by
  `strlen($separator)` and wraps with `wrapper[0]/[1]`. Emits `$element[0]['#markup'] = $formatted`.
- All dynamic values are escaped/cleaned (`Html::escape`, `Html::cleanCssIdentifier`), and the tag
  names come from fixed `#options`, so there is no untrusted-input HTML injection here. The tag/class
  strings are set by a user with field-display admin rights (Manage display), i.e. trusted config.

## `settingsSummary()`
Returns human-readable lines describing separator, links, element+class, wrapper+class (uses a few
`<br>` in translated strings).

## Configuring
- UI: *Manage display* for the entity/bundle/view-mode → set the term-reference field's format to
  "Taxonomy Formatter" → click the gear to edit the settings above.
- Code/config: in `core.entity_view_display.<entity>.<bundle>.<mode>.yml`, set the field component
  `type: taxonomy_term_reference_formatter` with a `settings:` map of the keys above.
