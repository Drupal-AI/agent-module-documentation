# Configure Simple Add More

## Settings form — `sam.admin_settings`

Path: `/admin/config/content/simple-add-more-settings` (menu: **Config → Content authoring →
Simple Add More Settings**). Permission: `administer sam`. Form class:
`Drupal\sam\Form\SamSettings` (a `ConfigFormBase`).

All four keys live in the config object **`sam.settings`** (schema in
`config/schema/sam.schema.yml`; defaults in `config/install/sam.settings.yml`). Edit in the
UI or with `drush cset sam.settings <key> '<value>'`. All fields are required.

| Key | Default | Meaning |
|---|---|---|
| `add_more_label` | `Add another item` | Label of the button that reveals one more empty element |
| `remove_label` | `Remove` | Label of the per-row button that clears a value |
| `help_text_singular` | `@count additional item can be added` | Help text when one item remains; `@count` = remaining count |
| `help_text_plural` | `@count additional items can be added` | Help text when >1 item remains; `@count` = remaining count |

These labels/strings are passed to the JS via `drupalSettings.sam.*`. Settings are a config
object, so they export/deploy with `drush config:export`.

## Per-widget opt-out (third-party setting)

SAM adds a **"Skip 'Simple Add More' simplification"** checkbox to each supported widget's
settings on the **Manage form display** page
(`hook_field_widget_third_party_settings_form()`). Stored as the third-party setting
`sam.skip_simplification` (boolean; schema key `field.widget.third_party.sam`). When checked,
that widget renders all empty elements as core normally does.

## When SAM acts (and when it doesn't)

Logic lives in `sam_skip_widget()` / `sam_field_widget_complete_form_alter()` in `sam.module`.
SAM simplifies a widget only when **all** hold:

- Field storage cardinality is **> 1** (fixed limited cardinality). Single-value and
  unlimited (`-1`) fields are skipped.
- The widget is **not** marked with the `skip_simplification` third-party setting.
- The widget's plugin id is in the supported list (`SAM_ALLOWED_WIDGET_TYPES`):
  `email_default`, `entity_reference_autocomplete`, `link_attributes`, `link_default`,
  `linkit`, `number`, `path`, `string_textarea`, `string_textfield`, `telephone`,
  `telephone_default`, `text_textarea`, `text_textarea_with_summary`, `text_textfield`, `uri`.

To add widget types to that list, implement `hook_sam_allowed_widget_types_alter()` — see
[../hooks/hooks.md](../hooks/hooks.md).
