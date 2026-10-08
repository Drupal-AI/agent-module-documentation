# IEF Complex Widget Dialog (ief_popup) — agent index

Makes the `inline_entity_form` **Complex** widget open its add/edit/duplicate/remove/add-existing
sub-forms as a modal popup instead of inline. Enabled per widget by one checkbox. All logic is in
`ief_popup.module` (no `src/`); no config UI (`configure` null), no permissions, no schema.
Depends on `inline_entity_form`.

- **The enabling checkbox, the form-alter flow, the dialog markup/library, and the JS/CSS** →
  [configure/ief_popup.md](configure/ief_popup.md)

Key facts:
- Setting: `third_party_settings.ief_popup.ief_popup_enabled` (bool) on an
  `InlineEntityFormComplex` widget, added via `hook_field_widget_third_party_settings_form()`.
- When on, `ief_popup__process_ief_form()` wraps the IEF sub-form in `ui-dialog`/`ief-popup-*` markup
  with a contextual title and close button; `#after_build` classes the action buttons.
- Library `ief_popup/ief_popup` (`js/ief_popup.js`, `css/ief_popup.css`; deps `core/jquery`,
  `core/drupal`, `core/drupal.dialog`) is attached on every page via `hook_preprocess_page()`.
- Special-cases Layout Builder (`ConfigureBlockFormBase`) and node/block_content/taxonomy_term/user hosts.
