<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Bootstrap Button (ept_bootstrap_button) — agent index

Ships **one Paragraphs bundle**, `ept_bootstrap_button`, that renders a link as a **Bootstrap 5
button**. Version **2.0.0**. Core `^10.1 || ^11 || ^12`. Package *Extra Paragraph Types*.
License GPL-2.0-or-later. Depends on **`ept_core`** and **`paragraphs`** (config also pulls in
core `link` and `text`).

**No routes, no permissions, no config form, no services beyond a hook class, no Drush.** It is
pure content-building furniture: a paragraph type + one field widget + one template.

- **The paragraph type, its fields, the settings widget, and how the button is rendered** →
  [fields/paragraph.md](fields/paragraph.md)

## What it actually provides

- **Paragraph bundle** `ept_bootstrap_button` (`config/install/paragraphs.paragraphs_type.ept_bootstrap_button.yml`).
- **Fields on the bundle** (all in `config/install/`):
  - `field_ept_bootstrap_button_link` — core **`link`** field, required, cardinality 1 (the button).
  - `field_ept_settings` — **`ept_settings`** field from `ept_core` (button + design options).
  - `field_ept_title` — `text_long` (optional heading above the button).
  - `field_ept_text` — `text_long` (optional text, hidden by the default template).
- **Field widget plugin** `EptSettingsBootstrapButtonWidget` (id `ept_settings_bootstrap_button`),
  in `src/Plugin/Field/FieldWidget/EptSettingsBootstrapButtonWidget.php`, extends
  `ept_core`'s `EptSettingsDefaultWidget`; adds a "Button options" details group. Bound to
  `field_ept_settings` by the default form display.
- **Template** `templates/paragraph--ept-bootstrap-button--default.html.twig` — composes the
  `btn`/`btn-*` classes and prints the `<a>`.
- **CSS library** `ept_bootstrap_button/ept_bootstrap_button_view` (`css/ept_bootstrap_button_view.css`),
  attached by the template.
- **Hook class** `src/Hook/EptBootstrapButtonHooks.php` (OOP `#[Hook('help')]`; legacy shim in the
  `.module`) — provides `hook_help` only, wired via `ept_bootstrap_button.services.yml` (autowired).

## Key facts for agents

- **No config schema** ships here (`config/` has only `install/`, no `schema/`); the
  `ept_settings` field's schema lives in `ept_core`.
- **Assumes Bootstrap 5.** Emitted classes (`btn`, `btn-primary`, `btn-outline-*`, `btn-lg`, …) are
  Bootstrap's; on a non-Bootstrap theme the button is unstyled. Widget descriptions link to the
  Bootstrap 5.3 docs.
- The custom-class field is validated by `ept_core`'s `EptGenericValidator::validateClassElement`
  (each class must match `^[a-zA-Z][a-zA-Z0-9_-]*$`).
