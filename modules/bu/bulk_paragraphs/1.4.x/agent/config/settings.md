<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings: increment options + per-widget toggle

## Admin settings form

- Route `bulk_paragraphs.settings` → `/admin/config/content/bulk-paragraphs`, requirement
  `_permission: 'administer site configuration'`. Menu link `bulk_paragraphs.settings`
  (`bulk_paragraphs.links.menu.yml`) under `system.admin_config_content`.
- Form `\Drupal\bulk_paragraphs\Form\BulkParagraphsSettingsForm` (extends `ConfigFormBase`,
  editable config `bulk_paragraphs.settings`, form id `bulk_paragraphs_settings_form`).
- Fields:
  - `date_increment_options` — checkboxes, allow-list `+1 day`, `+1 week`, `+1 month`.
  - `date_increment_default` — select (`- None -` or one of the above).
  - `numeric_increment_options` — checkboxes, allow-list `+1`, `+5`, `+10`.
  - `numeric_increment_default` — select (`- None -` or one of the above).
- `submitForm()` stores `array_values(array_filter(...))` of the checked options, and blanks a
  default that is not among the selected options before saving.

## Config object `bulk_paragraphs.settings`

Schema `config/schema/bulk_paragraphs.schema.yml` (type `config_object`):

| key | type | meaning |
|-----|------|---------|
| `date_increment_options` | sequence of string | date patterns offered in the generate form |
| `date_increment_default` | string | preselected date pattern (or empty) |
| `numeric_increment_options` | sequence of string | numeric patterns offered |
| `numeric_increment_default` | string | preselected numeric pattern (or empty) |

Install defaults (`config/install/bulk_paragraphs.settings.yml`):

```yaml
date_increment_options:
  - '+1 day'
  - '+1 week'
  - '+1 month'
date_increment_default: ''
numeric_increment_options:
  - '+1'
  - '+5'
  - '+10'
numeric_increment_default: ''
```

## How the generate form consumes it

`BulkGenerateForm::loadIncrementSettings()` reads the config; each `*_options` value falls back to
the full hard-coded list when empty, and each `*_default` is reset to `''` if not present in its
options. The date/numeric default-input builders (`buildDateFieldElement()`,
`buildNumericFieldElement()`) render `- None -` plus only the configured options, preselecting the
configured default. So this form only *narrows* the choices editors see — the generate form still
validates values against the fixed allow-list.

## Per-widget enable/disable (third-party setting)

Not part of this config object — stored on each ParagraphsWidget's third-party settings under
namespace `bulk_paragraphs`, key `enabled` (default TRUE):

- `#[Hook('field_widget_third_party_settings_form')] fieldWidgetThirdPartySettingsForm()` adds the
  checkbox **"Enable Bulk Paragraphs generation"** to the ParagraphsWidget settings on *Manage
  form display*.
- `#[Hook('field_widget_settings_summary_alter')] fieldWidgetSettingsSummaryAlter()` appends
  `Bulk Paragraphs: Enabled|Disabled` to that widget's summary.
- When unchecked, `fieldWidgetCompleteFormAlter()` skips adding the bulk buttons for that widget.
