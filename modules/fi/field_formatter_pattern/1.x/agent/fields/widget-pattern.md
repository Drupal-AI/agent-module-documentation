<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-widget HTML5 pattern validation

## Install & enable

```bash
composer require drupal/field_formatter_pattern
drush en field_formatter_pattern -y
```

No dependencies beyond Drupal core, no sub-modules, no permissions of its own, no routes, no
Drush commands. It only defines hook implementations and one service.

## Important: it is a WIDGET feature, not a formatter

The project name is misleading. This module does **not** register a field-formatter plugin and
does **not** change how a field is displayed. It adds settings to the field **widget** on the
**edit form** and, at form render, sets the HTML5 `pattern` attribute on the input so the
browser validates the typed value client-side.

## Configure it on a field

1. *Structure → (bundle) → **Manage form display***.
2. Click the **gear** on an eligible text field's widget.
3. Fill in:
   - **Pattern** — an HTML5 `pattern` regular expression (JavaScript regex syntax, anchored
     implicitly to the whole value by the browser), e.g. `[0-9]{4}` or `#[0-9A-Fa-f]{6}`.
   - **Pattern error message** — text shown by the browser and placed on the input's `title`
     attribute.
4. **Update**, then **Save**.

The settings appear on any entity type's Manage form display (nodes, users, terms, custom
entities), because they are attached to the widget, not to a bundle.

### Eligible widgets

`WidgetSettings::getAllowedSettingsForAll()` (`src/WidgetSettings.php`) hardcodes these widget
plugin IDs as pattern-eligible (each with `pattern => TRUE`, `pattern_error_message => TRUE`):

`string_textfield`, `string_textarea`, `text_textfield`, `text_textarea`,
`text_textarea_with_summary`, `key_value_textarea`.

`getAllowedSettings($widget_plugin_id)` returns that map for a given widget, or `[]` if the
widget is not listed — which is why the extra settings only show up on those widgets.

## How the value flows (source-accurate)

All logic is in `src/Hook/FieldFormatterPatternHooks.php`:

- **`fieldWidgetThirdPartySettingsForm()`** (`#[Hook('field_widget_third_party_settings_form')]`):
  looks up `getAllowedSettings($plugin->getPluginId())`; if `pattern` is allowed, it renders two
  `#type => textfield` elements (`pattern`, `pattern_error_message`) pre-filled from
  `$plugin->getThirdPartySetting('field_formatter_pattern', …)`.
- **`fieldWidgetFormAlter()`** (`#[Hook('field_widget_form_alter')]`, a `public static` method):
  reads `$context['widget']->getThirdPartySettings()` and, when set, does
  `$element['value']['#attributes']['pattern'] = …` and
  `$element['value']['#attributes']['title'] = …`. The pattern/message are emitted as **HTML
  attributes on the input** (escaped by Drupal's attribute rendering); the browser enforces the
  regex on submit.
- **`fieldWidgetSettingsSummaryAlter()`** (`#[Hook('field_widget_settings_summary_alter')]`):
  when a pattern is set, appends `Pattern: @pattern` to the Manage-form-display summary line.
- **`help()`** (`#[Hook('help')]`): returns the one-line help on
  `help.page.field_formatter_pattern`.

The `.module` file wraps each of these with a `#[LegacyHook]` shim that delegates to the service
`Drupal\field_formatter_pattern\Hook\FieldFormatterPatternHooks` (registered `autowire: true` in
`field_formatter_pattern.services.yml`).

## Where settings are stored (config)

Values live inside the **form-display** config entity as third-party settings, not in a
standalone config object. Schema `field.widget.third_party.field_formatter_pattern`
(`config/schema/field_formatter_pattern.schema.yml`) defines:

```yaml
field.widget.third_party.field_formatter_pattern:
  type: mapping
  mapping:
    pattern:
      type: label
    pattern_error_message:
      type: label
```

Example fragment inside `core.entity_form_display.node.article.default`:

```yaml
content:
  field_code:
    type: string_textfield
    third_party_settings:
      field_formatter_pattern:
        pattern: '[A-Z0-9]{6}'
        pattern_error_message: 'Enter 6 uppercase letters or digits.'
```

## Extend to more widgets

Register additional pattern-eligible widgets from your own module
(`field_formatter_pattern.api.php`):

```php
function mymodule_field_formatter_pattern_widget_settings() {
  return [
    'my_custom_text_widget' => ['pattern' => TRUE],
  ];
}
```

`WidgetSettings::getAllowedSettingsForAll()` merges these (`$settings + invokeAll(...)`) with the
built-in list.

## Caveats / notes

- The check is the **browser's native HTML5 `pattern`** attribute only — it is a convenience
  guardrail on the edit form, not a server-side validation constraint. A submission that bypasses
  the browser (API, disabled JS/HTML validation, direct request) is **not** blocked by this
  module. For hard enforcement use a real field-constraint/validation approach.
- The `@todo` in the hook notes settings edge-values (0/negative) and schema completeness are
  untested by the author.
- `fieldWidgetFormAlter()` is declared `public static` yet the `.module` shim calls it as an
  instance method — harmless in practice, but a style inconsistency to be aware of when reading
  the code.
