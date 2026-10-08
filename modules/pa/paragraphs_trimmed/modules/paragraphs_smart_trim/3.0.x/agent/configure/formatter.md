# Formatter: paragraphs_smart_trim

The submodule's only capability: a field formatter that trims rendered Paragraphs output using
the contrib Smart Trim formatter.

## Plugin

- **Id:** `paragraphs_smart_trim`  •  **Label:** "Paragraphs Smart Trim"
- **Applies to field type:** `entity_reference_revisions` (Paragraphs fields).
- **Class:** `Drupal\paragraphs_smart_trim\Plugin\Field\FieldFormatter\ParagraphsSmartTrimFormatter`
  extending the parent `ParagraphsTrimmedFormatterBase`.
- Trimmer used: contrib Smart Trim, plugin id `smart_trim` (returned by `getTrimFormatterType()`).
  **`smart_trim` must be enabled** or this formatter is unavailable.

## Settings

Inherited from the parent base class:

- `view_mode` — paragraph view mode used to render before trimming.
- `link` — whether to link the rendered entity (from EntityReferenceRevisionsEntityFormatter).
- `format` — text format applied to the rendered paragraphs HTML before trimming (default `full_html`).
- `summary_field` — optional field on the host entity; if set and non-empty, it is rendered
  (label hidden) instead of the trimmed paragraphs.

Plus all settings the `smart_trim` formatter itself exposes (e.g. trim length, trim by
characters or words, suffix, "more" link) — its form and defaults are merged in by the base class.

Submodule-specific:

- `summary_handler` — forced to `ignore` in `defaultSettings()` and rendered as a hidden `value`
  element in the settings form (Smart Trim's own summary handling is not offered here).

## How to apply it

1. Enable `smart_trim` and `paragraphs_smart_trim`.
2. UI: Structure → Content types → *(type)* → **Manage display** (or the relevant view mode).
   For the Paragraphs field, choose **Paragraphs Smart Trim** in the Format column, open the
   settings gear, set the view mode, text format, summary field, and Smart Trim's trim options,
   Update, Save.

Config: standard formatter stored under `content` in
`core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

```yaml
content:
  field_body_paragraphs:
    type: paragraphs_smart_trim
    label: hidden
    settings:
      view_mode: default
      link: false
      format: full_html
      summary_field: ''
      summary_handler: ignore
      # + smart_trim's own settings (trim_length, trim_type, more link, suffix, ...)
    weight: 0
```

## Notes

- The rendered paragraphs are passed through the configured text `format` (a real text format)
  before Smart Trim trims the markup.
- No config schema ships with the submodule; settings live on the display entity.
- Not verified live: `smart_trim` is not installed on this site, so the exact Smart Trim setting
  keys above are described from Smart Trim's known formatter and the submodule source, not from a
  running plugin definition.
