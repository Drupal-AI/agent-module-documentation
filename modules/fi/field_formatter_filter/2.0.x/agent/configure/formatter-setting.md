# Field Formatter Filter — the formatter setting

All behavior lives in `field_formatter_filter.module` (procedural hooks).

## Where you set it
*Manage display* for a bundle/view mode (e.g. `/admin/structure/types/manage/page/display/teaser`).
Open the gear/settings for a `text`/`text_long`/`text_with_summary` field; a select
**"Additional Text Filter/Format"** appears listing `<none>` + every filter format. Requires core
Field UI to edit.

## How it's stored
Third-party setting on the entity view display component:

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>
content:
  <field_name>:
    third_party_settings:
      field_formatter_filter:
        format: teaser_safe_text   # a filter.format id, or a falsey value for <none>
```

Config schema key: `field.formatter.third_party.field_formatter_filter` → `mapping.format` (string).

## Hooks that implement it
- `field_formatter_filter_field_formatter_third_party_settings_form()` — injects the `format` select
  (only for the three text field types, gated by `_field_formatter_filter_target_field_type()`).
- `field_formatter_filter_field_formatter_settings_summary_alter()` — appends "Text Format: <label>"
  to the Manage display summary.
- `field_formatter_filter_preprocess_field()` — the render override: loads the display component, reads
  `third_party_settings.field_formatter_filter.format`, and for each rendered child sets
  `$variables['items'][$key]['content']['#format'] = $format_id`. Core's
  `Drupal\filter\Element\ProcessedText::preRenderText` then applies that format. If the format id no
  longer resolves (`FilterFormat::load` fails), it logs a warning and leaves default rendering.

## Behavior notes
- Display-only: the stored field value/format is unchanged; only the rendered output for that view mode
  is re-filtered through the chosen format.
- The selected format runs *instead of* the field's own format, not in addition — so the format you pick
  must itself be safe (it is an admin-defined `filter.format`). Running two filter chains can have
  side effects; the maintainer recommends keeping the additional format simple.
- Set the select back to `<none>` to disable.
