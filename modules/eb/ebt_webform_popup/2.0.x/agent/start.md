<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Webform Popup (ebt_webform_popup) — agent index

Installs a `block_content` bundle **`ebt_webform_popup`** ("EBT Webform Popup") — a Webform
entity reference plus the shared EBT settings field — that renders a button which opens the
selected Webform in a jQuery UI **modal/dialog** popup (Drupal core `use-ajax` dialog). Built on
the EBT (`ebt_core` / `ebt_basic_button`) framework. No routes, no permissions, no services of
its own beyond a hook class. Version 2.0.x, core `^10.1 || ^11 || ^12`, package "Extra Block Types".

## Dependencies

- `drupal/ebt_basic_button` `^2.0` (button widget base + `ebt_basic_button.generate_custom_css` service)
- `drupal/ebt_core` `^2.0` (provides the `ebt_settings` field type, `ebt_settings_default` formatter,
  `ebt_core.generate_css` service + `ebt_core.settings`)
- `drupal/paragraphs` `^1.0`
- `drupal/webform` `^6.0`
- info.yml declares deps: `ebt_basic_button`, `paragraphs`, `webform` (`ebt_core` arrives via
  `ebt_basic_button`; the installed field/display config depends on `ebt_core` + `webform`).

## What it provides

- **Block content type** `ebt_webform_popup` (`config/install/block_content.type.ebt_webform_popup.yml`)
  with fields:
  - `field_ebt_webform_popup_form` — `webform` entity reference, **required**, cardinality 1
    (`field.storage`/`field.field` in `config/install/`); selects the form shown in the popup.
  - `field_ebt_settings` — `ebt_settings` (from `ebt_core`); button + popup + design settings.
- **Field widget plugin** `ebt_settings_webform_popup` —
  `src/Plugin/Field/FieldWidget/EbtSettingsWebformPopupWidget.php` (extends
  `EbtSettingsBasicButtonWidget`); adds button text + a "Popup settings" details group.
- **Hook class** `EbtWebformPopupHooks` (`src/Hook/EbtWebformPopupHooks.php`, autowired service):
  `help` (hook_help) and `preprocessBlock` (hook_preprocess_block) — attaches `webform/webform.ajax`,
  resolves the form URL, builds `data-dialog-options`/`data-dialog-type`, and computes `button_styles`.
- **Templates** `templates/block--block-content--ebt-webform-popup.html.twig` and
  `templates/block--inline-block--ebt-webform-popup.html.twig` (the block vs Layout-Builder inline
  variants). They render a `<a class="use-ajax …">` trigger and emit `{{ styles|raw }}` +
  `{{ button_styles|raw }}`; they attach `ebt_basic_button/ebt_basic_button_view`.
- **Install/view/form display config** in `config/install/` (default form uses the
  `ebt_settings_webform_popup` widget and a `webform_entity_reference_select` widget).

No config-schema files (`provides_config_schema: false`), no `.install`, no Drush commands, no
settings route (`configure` is null), no submodules.

## Solution docs

- [Block type, fields & display](agent/blocks/webform-popup-block.md) — the bundle, its two fields,
  form/view displays, install/enable, and how instances are created and placed.
- [Popup settings widget, preprocess & rendering](agent/config/settings.md) — the
  `ebt_settings_webform_popup` widget options, `preprocessBlock()`, the dialog wiring, and the two
  Twig templates.
