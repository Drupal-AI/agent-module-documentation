# Hide format info on a field widget

No admin route. Settings are **third-party widget settings** exposed on
**Manage form display** (`/admin/structure/types/manage/{bundle}/form-display`) for any
`text`, `text_long`, or `text_with_summary` field. Click the widget's gear/settings icon.

Two checkboxes (via `hook_field_widget_third_party_settings_form()`):
- **Hide the help link *About text formats*** → key `hide_help`
- **Hide text format guidelines** → key `hide_guidelines`

## How it works
`allowed_formats_field_widget_single_element_form_alter()` reads the widget's
`allowed_formats` third-party settings and, if either is set, registers the
`_allowed_formats_remove_textarea_help` `#after_build` callback. That callback unsets
`$element['format']['help']` and/or `$element['format']['guidelines']`. If both are hidden
and only one format is available, the whole `format` wrapper (`#type`, `#theme_wrappers`)
is removed too. Not applied to the default-value widget.

## As config (form display export)
Stored on the widget under `third_party_settings.allowed_formats`:
```yaml
# core.entity_form_display.node.article.default.yml (excerpt)
content:
  body:
    type: text_textarea_with_summary
    third_party_settings:
      allowed_formats:
        hide_help: '1'
        hide_guidelines: '1'
```
Schema: `field.widget.third_party.allowed_formats` (`hide_help`, `hide_guidelines` — both
stored as strings).
