<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Webform Popup (ept_webform_popup) — agent index

Config-only EPT paragraph type: a **button that opens an admin-selected Webform in a core AJAX
popup/modal**. No custom entities, routes, services, permissions, or Drush. Package
`Extra Paragraph Types`. Version **1.4.3** (version-dir `1.4.x`). Core `^9.3 || ^10 || ^11`.
License GPL-2.0-or-later.

Dependencies (`ept_webform_popup.info.yml`): `ept_basic_button`, `paragraphs`, `webform`
(`ept_basic_button` in turn brings `ept_core`). Composer: `drupal/ept_basic_button:^1.4`,
`drupal/paragraphs:^1.0`, `drupal/webform:^6.0`.

## What it actually is

- One **paragraph type** `ept_webform_popup` (`config/install/paragraphs.paragraphs_type.ept_webform_popup.yml`),
  installed with four fields:
  - `field_ept_webform_popup_form` — **entity_reference of field type `webform`** (`target_type: webform`,
    handler `default:webform`, `required: true`, cardinality 1). The form is **admin-selected**, not free text.
  - `field_ept_settings` — shared EPT settings field (from `ept_core`), edited by this module's widget.
  - `field_ept_title`, `field_ept_text` — optional title/text (from `ept_core`).
- One **field widget** `ept_settings_webform_popup` (`EptSettingsWebformPopupWidget`), extending
  `ept_basic_button`'s `EptSettingsBasicButtonWidget`. Adds button text + popup settings.
- One **Twig template** `templates/paragraph--ept-webform-popup--default.html.twig` and one
  preprocess hook `ept_webform_popup_preprocess_paragraph()` in `ept_webform_popup.module`.
- No `.routing.yml`, `.permissions.yml`, `.services.yml`, `.libraries.yml`, `.install`, or
  `config/schema/`. `field_ept_settings` schema/config live in `ept_core`.

## Rendering (from source)

- `ept_webform_popup_preprocess_paragraph()` attaches `webform/webform.ajax`, sets
  `form_url` = the referenced Webform's `->toUrl()`, builds `button_styles` via the
  `ept_basic_button.generate_custom_css` service, and JSON-encodes dialog options
  (`popup_width`, `form_height`/height, `popup_title`, `classes`) into `data_dialog_options`;
  `data_dialog_type` = `popup_type` (`modal`|`dialog`, default `modal`); `button_text` default
  `Contact Us`.
- Template renders `<a class="use-ajax ept-basic-button ept-webform-popup" data-dialog-type=…
  data-dialog-options=…>` → core AJAX opens the Webform's own page in a jQuery UI dialog. The
  Webform enforces its **own access/handlers/validation** at its route; the paragraph adds no access bypass.
- `styles` (from `ept_core` `GenerateCSS`) and `button_styles` (from `ept_basic_button`
  `GenerateCustomCSS`) are server-generated `<style>` blocks printed with `|raw`; both build every
  value with `Html::escape()`.

## Solution docs

- Paragraph type, fields, preprocess, template, install/operate → [paragraphs/webform-popup.md](paragraphs/webform-popup.md)
- The `ept_settings_webform_popup` field widget and its settings → [plugins/widget.md](plugins/widget.md)
