# Formatter: paragraphs_trimmed

The module's only capability: a field formatter that trims rendered Paragraphs output.

## Plugin

- **Id:** `paragraphs_trimmed`  •  **Label:** "Paragraphs Trimmed"
- **Applies to field type:** `entity_reference_revisions` (the field type Paragraphs fields use).
- **Class:** `Drupal\paragraphs_trimmed\Plugin\Field\FieldFormatter\ParagraphsTrimmedFormatter`
  extending `ParagraphsTrimmedFormatterBase` extending core's
  `EntityReferenceRevisionsEntityFormatter`.
- Trimmer used: core's Trimmed formatter, plugin id `text_trimmed`
  (returned by `getTrimFormatterType()`).

## Settings (verified defaults on the live site)

```
{"summary_field":"", "format":"full_html", "view_mode":"default", "link":false, "trim_length":"600"}
```

- `view_mode` — inherited from EntityReferenceRevisionsEntityFormatter. The paragraph view mode
  used to render the referenced paragraphs before trimming. Default `default`.
- `link` — inherited; whether to link the rendered entity. Default false.
- `format` — a text format id applied to the rendered paragraphs HTML before trimming.
  Default `full_html`. The settings form lists all filter formats.
- `trim_length` — inherited from the `text_trimmed` formatter; the character length to trim to.
  Default `600`.
- `summary_field` — optional. A field name on the host entity. Options are all `FieldConfig`
  fields on the field's bundle plus "- None -". If set and the named field has a value, that
  field is rendered (label hidden) **instead** of the trimmed paragraphs.

The settings summary shows the chosen text format label, the summary field (if any), and the
underlying Trimmed formatter's own summary.

## How to apply it

UI: Structure → Content types → *(type)* → **Manage display** (or the relevant view mode /
entity type). For the Paragraphs field's row, choose **Paragraphs Trimmed** in the Format
column, open the settings gear, set view mode / text format / trim length / summary field, Update, Save.

Config: it is a standard formatter, so it lives under `content` in an
`core.entity_view_display.<entity_type>.<bundle>.<view_mode>` config entity, e.g.:

```yaml
content:
  field_body_paragraphs:
    type: paragraphs_trimmed
    label: hidden
    settings:
      view_mode: default
      link: false
      format: full_html
      trim_length: 600
      summary_field: ''
    weight: 0
```

## Notes

- The rendered paragraphs HTML is passed through the configured `format` (a real text format),
  so the format's filters apply to the markup before it is trimmed.
- No config schema ships with the module; settings are stored on the display entity as above.
- For word-based trimming, a "more" link, or an ellipsis suffix, use the `paragraphs_smart_trim`
  submodule instead, which swaps the trimmer for the contrib Smart Trim formatter.
