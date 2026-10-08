# Citation Select services

| Service id | Class | Use |
|---|---|---|
| `citation_select.citation_processor` | `CitationProcessorService` | Build a CSL-JSON data array from a node. |
| `citation_select.citation_styler` | `CitationStyler` | Render CSL-JSON to a formatted citation string via citeproc-php. |
| `citation_select.human_name_parser` | `HumanNameParser` | Parse a name string into parts (`adci/full-name-parser`). |
| `plugin.manager.citation.field.formatter` | `CitationFieldFormatterPluginManager` | Manager for the `CitationFieldFormatter` plugin type (see plugins doc). |

## `CitationProcessorService`

`getCitationArray($nid, $langcode = 'en'): array`
- Loads the node (translation-aware), iterates the `csl_map` config, and for each mapped node field selects a
  `CitationFieldFormatter` plugin by the field type (else `default`), calling `formatMultiple()` and merging
  the result.
- Resolves the CSL `type` via `getValidType()` using `reference_type_field_map` (lowercased key), falling
  back to a hardcoded list of valid CSL types, else `document`.
- Returns a CSL-JSON associative array (person fields as name objects, date fields as `date-parts`, etc.).

```php
$data = \Drupal::service('citation_select.citation_processor')->getCitationArray($node->id(), 'en');
```

## `CitationStyler` (`CitationStylerInterface`)

Adapted from Bibcite. Renders CSL-JSON with `Seboettg\CiteProc\CiteProc`:
- `setStyleById($style_id)` / `setStyle($cslStyleEntity)` — select a `citation_select_csl_style` entity
  (throws `UnexpectedValueException` if the id doesn't exist).
- `getStyle()` — defaults to config `default_style`.
- `getAvailableStyles()` / `getEnabledStyles()` — all / enabled style entities.
- `setLanguageCode($lang)` / `getLanguageCode()` — defaults to current language.
- `render($data): string` — `new CiteProc($cslXml, $lang)->render([$data])` (accepts array or `\stdClass`;
  strips newlines).

```php
$styler = \Drupal::service('citation_select.citation_styler');
$citation = $styler->setStyleById('apa')->render($data);
```

> Callers should `Xss::filter` the data before rendering (as `SelectCitationForm` does) since CSL output can
> contain field values.

## `HumanNameParser`

`parse(string $name): array` → parts (`prefix`, `first_name`, `last_name`, `suffix`) via
`adci/full-name-parser`. Used by `CitationFieldFormatterBase::convertName()` to build CSL person objects;
unparseable names fall back to `{literal: <name>}`.

## Supporting classes

- `Csl` — thin wrapper over CSL XML (`simplexml_load_string`): `getId()`, `getTitle()`, `getParent()`,
  `validate()`. Used by the style add/upload forms.
- `CslStyle` (`citation_select_csl_style` ConfigEntity) — stores the CSL text and metadata;
  `admin_permission: administer site configuration`.
