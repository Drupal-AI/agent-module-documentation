<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph type: ept_webform_popup

Config-only paragraph that renders a button opening a Webform in a core AJAX dialog. All logic is
one preprocess hook + one Twig template; no PHP entities/controllers/services of its own.

## Install / enable

- `composer require drupal/ept_webform_popup` then enable `ept_webform_popup` (pulls in
  `ept_basic_button` → `ept_core`, `paragraphs`, `webform`).
- Enabling installs the paragraph type and fields from `config/install/`. There is **no settings
  route** (`configure: null`); family-wide defaults (colors, breakpoints) live in `ept_core.settings`,
  edited at the EPT Core settings form. Add the paragraph type to any Paragraphs field, then set
  values per instance while authoring.

## Config installed (`config/install/`)

- `paragraphs.paragraphs_type.ept_webform_popup.yml` — the paragraph type `ept_webform_popup`
  (label "EPT Webform Popup", no behavior plugins).
- `field.storage.paragraph.field_ept_webform_popup_form.yml` — field storage, **type `webform`**
  (from the Webform module), `target_type: webform`, cardinality 1.
- `field.field.paragraph.ept_webform_popup.field_ept_webform_popup_form.yml` — label "Webform",
  `required: true`, handler `default:webform`, `target_bundles: null`, `auto_create: false`. The
  content editor picks one existing Webform; there is no free-text form entry.
- `field.field.paragraph.ept_webform_popup.field_ept_settings.yml` — the shared `ept_settings`
  field (design + button + popup settings; schema defined by `ept_core`).
- `field.field.paragraph.ept_webform_popup.field_ept_title.yml`, `…field_ept_text.yml` — optional
  title/body.
- `core.entity_form_display.*` / `core.entity_view_display.*` — wire the form display to the
  `ept_settings_webform_popup` widget and the view display fields.

## Preprocess: `ept_webform_popup_preprocess_paragraph()` (`ept_webform_popup.module`)

Guards on `bundle() === 'ept_webform_popup'`, then:

- `#attached['library'][] = 'webform/webform.ajax'` (per drupal.org/node/3456067).
- `form_url` = `content['field_ept_webform_popup_form'][0]['#webform']->toUrl()` — the referenced
  Webform's canonical URL.
- `button_styles` = `\Drupal::service('ept_basic_button.generate_custom_css')
  ->generateFromSettings($ept_settings[0]['ept_settings'], 'paragraph-id-<id>')` — a `<style>` block
  scoped to this paragraph's id class.
- `data_dialog_options` = `Json::encode([...])` with:
  - `width` = `popup_settings.popup_width` (px stripped),
  - `height` = `popup_settings.popup_height` if set else `'auto'` (note: the widget stores the field
    as `form_height`; only a non-empty `popup_height` key overrides auto),
  - `classes` = `{ 'ui-dialog': 'ui-dialog-webform-popup' }`,
  - `title` = `popup_settings.popup_title` when non-empty.
- `data_dialog_type` = `popup_settings.popup_type` (default `'modal'`).
- `button_text` = `ept_settings.button_text` (default `t('Contact Us')`).

Note `styles` (the design-options `<style>`) is set upstream by `ept_core_preprocess_paragraph()`
via the `ept_core.generate_css` service; this module does not set `styles` itself.

## Template: `templates/paragraph--ept-webform-popup--default.html.twig`

- Builds wrapper classes (`ept-basic-button`, alignment/shape/size/stretched from `ept_settings`),
  attaches `ept_basic_button/ept_basic_button_view`.
- Renders the trigger:
  `<a href="{{ form_url }}" class="use-ajax ept-basic-button ept-webform-popup {{ button_custom_classes }}"
  data-dialog-type="{{ data_dialog_type }}" data-dialog-options="{{ data_dialog_options }}">{{ button_text }}</a>`.
  `use-ajax` + these data attributes are Drupal core's dialog API; clicking loads `form_url` (the
  Webform page) into a jQuery UI modal/dialog. `button_text` and the attributes are printed through
  Twig auto-escaping (no `|raw`).
- Prints `{{ content|without('field_ept_settings','field_ept_webform_popup_form','field_ept_title') }}`
  for any extra fields, then `{{ styles|raw }}` and `{{ button_styles|raw }}` — the two
  server-generated, `Html::escape()`-built `<style>` blocks.

## Operate / customize

- Per instance (paragraph form): button text (required), popup width (required), form height,
  popup title, popup type (modal/dialog), plus the shared EPT design/button-style options.
- The opened Webform is a normal Webform route: its access, confirmation, handlers and validation
  all apply unchanged; this paragraph only styles and triggers the dialog.
- To restyle the dialog, target the `ui-dialog-webform-popup` class or `.ept-webform-popup` button.
