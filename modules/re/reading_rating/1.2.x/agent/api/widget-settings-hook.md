<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_reading_rating_widget_settings()

Reading Rating only exposes its "Enable Reading Rating" checkboxes on a fixed list of core text
widgets (`string_textarea`, `text_textarea`, `text_textarea_with_summary`). To make the setting
available on **another widget** — a custom or contrib textarea-style widget — implement this hook.

It is the module's single extension point. There is no plugin type; this is a plain `invokeAll`
hook aggregated in `WidgetSettings::getAllowedSettingsForAll()`.

## Signature
Return an array keyed by the **widget plugin id**. Each entry:

```php
/**
 * Implements hook_reading_rating_widget_settings().
 */
function mymodule_reading_rating_widget_settings() {
  return [
    // Key = the field widget plugin id to enable Reading Rating on.
    'my_custom_textarea_widget' => [
      // Show the "Enable Reading Rating" checkbox for this widget.
      'reading_rating_setting' => TRUE,
      // Reserved for future summary-field rating; core widgets set FALSE.
      'summary_reading_rating_setting' => TRUE,
      // Optional: the field property/column the value lives in. Defaults to 'value'.
      'column' => 'value',
    ],
  ];
}
```

## Keys
- `reading_rating_setting` (bool) — whether the widget gets the Reading Rating settings details and,
  when enabled, the live widget. Required to make the widget participate.
- `summary_reading_rating_setting` (bool) — flags a summary column; the core
  `text_textarea_with_summary` sets it. Rating of summary fields is a **planned** feature, so this is
  effectively a forward-looking flag today.
- `column` (string, optional) — the element key that holds the text (`$element[$column]`). Defaults
  to `'value'`; set it if your widget stores text under a different property.

## How it is consumed
- `WidgetSettings::getAllowedSettingsForAll()` merges your hook return **after** the built-in three
  (`$settings + $additional_widget_settings`), so you cannot override a built-in widget's config,
  only add new ones.
- `getAllowedSettings($widget_plugin_id)` returns your entry when the form display's widget matches.
- `hook_field_widget_third_party_settings_form()` then renders the "Reading Rating Settings" details
  for that widget, and `hook_field_widget_single_element_form_alter()` uses `column` to place the
  `#enable_reading_rating` flag on the right element.

See `reading_rating.api.php` for the canonical example.
