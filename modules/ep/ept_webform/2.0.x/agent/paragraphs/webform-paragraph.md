<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ept_webform` paragraph type

`ept_webform` is a **config-only** module. Everything it does is expressed through the config it
installs and the one Twig template; there is no `src/` and no runtime PHP of its own. The behaviour
that turns settings into markup lives in **`ept_core`**.

## Config installed (`config/install/`)

- `paragraphs.paragraphs_type.ept_webform.yml` — the paragraph type "EPT Webform", no behavior plugins.
- `field.storage.paragraph.field_ept_webform_form.yml` — field storage, type **`webform`**
  (`target_type: webform`), cardinality 1, translatable.
- `field.field.paragraph.ept_webform.field_ept_webform_form.yml` — the field on the bundle:
  label "Form", **`required: true`**, handler `default:webform`.
- `field.field.paragraph.ept_webform.field_ept_settings.yml` — attaches ept_core's
  `field_ept_settings` (type `ept_settings`) to the bundle.
- `field.field.paragraph.ept_webform.field_ept_text.yml` / `field_ept_title.yml` — the shared EPT
  text and title fields (storage comes from ept_core).
- `core.entity_form_display.paragraph.ept_webform.default.yml` — widgets: title/text as
  `text_textarea`, the form as **`webform_entity_reference_select`** (`default_data: true`),
  settings as `ept_settings_default`.
- `core.entity_view_display.paragraph.ept_webform.default.yml` — the form is rendered with
  **`webform_entity_reference_entity_view`** (`source_entity: true`, `lazy: false`); settings use
  the `ept_settings_default` formatter (label hidden).

There is **no `config/schema/`** in this module — the config entities above are typed by core,
paragraphs, webform and ept_core schemas.

## Render path

1. The bundle machine name starts with `ept_`, so ept_core's `hook_theme_registry_alter` /
   `hook_theme_suggestions_paragraph_alter` route it to this module's
   `templates/paragraph--ept-webform--default.html.twig`.
2. `webform_entity_reference_entity_view` renders the referenced webform. **All form behaviour —
   access, validation, submission storage, confirmation — is Webform's**; this module only chooses
   which form is shown and where it sits.
3. `ept_core_preprocess_paragraph` reads `field_ept_settings['design_options']`, calls the
   `ept_core.generate_css` service (`GenerateCSS::generateFromSettings`), and assigns the result to
   the `styles` template variable. The template prints it with `{{ styles|raw }}`. The CSS is scoped
   to a `paragraph-id-<id>` class so each paragraph styles only itself. Background image/video
   options additionally emit `drupalSettings` consumed by ept_core JS libraries.

## Shared EPT design settings

`field_ept_settings` gives every EPT paragraph the same Design options: an anchor ID, a CSS box
(margins / borders / padding), border color/style/radius, background color, a media background
(image with cover/contain/parallax or local/YouTube video), an optional overlay, edge-to-edge, and a
container max-width. Box values are numeric-validated; color fields are hex-validated. See the
`ept_core` docs for the full option set and the `GenerateCSS` mapping.

## Editorial flow

1. Add an **EPT Webform** paragraph to a paragraphs-enabled field.
2. Select an existing webform in the required **Form** field (build the webform first at
   `/admin/structure/webform`).
3. Optionally set title/text and open **Paragraph settings → Design options** for spacing/background.
4. The chosen form renders inline at the paragraph's position on save.

For a button that opens the form in a modal instead of rendering it inline, install
**EPT Webform Popup** (`ept_webform_popup`).
