# Configure Paragraphs Features

## Global setting
Form `\Drupal\paragraphs_features\Form\SettingsForm` at
`/admin/config/content/paragraphs_features` (route `paragraphs_features.settings_form`,
permission `administer site configuration`). Config `paragraphs_features.settings`:

- `dropdown_to_button` (bool, default false) — when a paragraph's actions drop-down has only
  one visible action, render it as a plain button (one less click). Applied in
  `hook_paragraphs_widget_actions_alter()`.

## Per-field widget features (third-party settings)
Set on the **Paragraphs (Stable/experimental) widget** of a form display:
*Structure → Content types → Manage form display → gear icon on the paragraphs field*.
Exposed via `hook_field_widget_third_party_settings_form()`; stored under the widget's
`third_party_settings.paragraphs_features` (schema
`field.widget.third_party.paragraphs_features`):

- `add_in_between` (bool) — show "+ Add" buttons between paragraphs.
- `add_in_between_link_count` (int) — number of paragraph-type quick links in that control.
- `delete_confirmation` (bool) — confirm before removing a paragraph.
- `show_drag_and_drop` (bool) — expose Paragraphs' advanced drag & drop UI (requires the
  `core/sortable` library).
- `show_collapse_all` (bool) — show/hide the collapse-all button.

These attach the module's JS libraries (`add_in_between`, `delete_confirmation`, …) to the
widget at render time (`ParagraphsFeatures::registerFormWidgetFeatures`).

Config is exportable like any form-display config.
