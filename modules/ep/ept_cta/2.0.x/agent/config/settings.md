<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Call to Action — the `ept_cta` bundle, fields, and `ept_settings_cta` widget

## Install / enable
`drush en ept_cta -y` (pulls `ept_basic_button` → `ept_core`, plus `paragraphs`, `link`, `media`).
`ept_cta.install`'s `hook_requirements('install')` **blocks install with an error** until a Media
type whose id is `image` exists (Structure » Media types » Add media type). On install the config
below imports and creates the `ept_cta` Paragraphs bundle. There is **no settings form in this
module**; site-wide EPT defaults (primary/secondary colors, mobile/tablet/desktop breakpoints,
default background color) live on `ept_core`'s configuration form. To use it, add a Paragraphs
(`entity_reference_revisions`) field to a node/entity and allow the `ept_cta` bundle.

## Config shipped (config/install)
- `paragraphs.paragraphs_type.ept_cta` — bundle `id: ept_cta`, label `EPT Call to Action (CTA)`,
  no behavior plugins.
- **Fields** (all optional, not required):
  - `field_ept_title` — `text_long`, `allowed_formats: {}` (any format the editor has).
  - `field_ept_text` — `text_long`, `allowed_formats: {}`.
  - `field_ept_cta_column_image` — `entity_reference` → `target_type: media`, **cardinality 1**,
    handler `default:media`, `target_bundles: { image: image }`. Storage
    `field.storage.paragraph.field_ept_cta_column_image` ships here.
  - `field_ept_cta_link` — `link`, `settings: { title: 1, link_type: 17 }` (title required; internal
    + external). Storage `field.storage.paragraph.field_ept_cta_link` ships here.
  - `field_ept_cta_second_link` — `link`, `settings: { title: 2, link_type: 17 }`. Storage ships here.
  - `field_ept_settings` — `ept_settings` (from `ept_core`); the Settings tab. Its storage and the
    title/text storages come from `ept_core`, not this module.
- `core.entity_form_display.paragraph.ept_cta.default` — `field_group` **Tabs**:
  - **Content** tab (`group_content`): `field_ept_title` (text_textarea), `field_ept_text`
    (text_textarea, 5 rows), `field_ept_cta_column_image` (`media_library_widget`),
    `field_ept_cta_link` + `field_ept_cta_second_link` (`link_default`).
  - **Settings** tab (`group_settings`, closed by default): `field_ept_settings` with widget
    **`ept_settings_cta`**.
- `core.entity_view_display.paragraph.ept_cta.default` — image via `entity_reference_entity_view`
  (view_mode default, no link), links via `link` formatter, `field_ept_settings` via
  `ept_settings_default`, title/text via `text_default`; all labels hidden.

## The settings widget — `EptSettingsCtaWidget`
`src/Plugin/Field/FieldWidget/EptSettingsCtaWidget.php`, `@FieldWidget(id = "ept_settings_cta",
field_types = {"ept_settings"})`, **extends `Drupal\ept_basic_button\Plugin\Field\FieldWidget\EptSettingsBasicButtonWidget`**
(which extends `ept_core`'s `EptSettingsDefaultWidget`). It injects `config.factory` and reads
`ept_core.settings` for the default mobile breakpoint.

`formElement()` = `parent::formElement()` (ept_core Design options + the Basic Button `link_options`
group: colors, shape, size, alignment, stretched, custom class) **plus** these elements, all keyed
under `ept_settings`:

| key | #type | options / default |
|---|---|---|
| `styles` | radios | `two_columns` (def), `two_columns_fluid`, `one_column` |
| `align_content` | radios | `left` (def), `center`, `right` |
| `image_position` | radios | `left` (def), `right` — image side in 2-column layout |
| `image_order_mobile` | radios | `image_first` (def), `image_last` — order after columns stack |
| `mobile_breakpoint` | number | default `ept_core_mobile_breakpoint` or `480` (px) |
| `pass_options_to_javascript` | hidden | `FALSE` |
| `button_styles` | html_tag `<h3>` | "CTA Button styles:" heading (weight -1) |

It then **clones the whole Basic Button `link_options` group into `link_options2`** (weight 3, title
"Second Link options") and re-seeds each `#default_value` from `link_options2` so the **second
button** has an independent set of style options: `open_in_new_tab`, `add_nofollow`, `title_color`,
`background_color`, `custom_hover_colors`, `hover_title_color`, `hover_background_color`, `alignment`,
`shape`, `size`, `stretched`, `custom_class_name`. The color fields inherit the inherited
`EptSettingsDefaultWidget::validateColorElement` (`Color::validateHex`) validation, and
`custom_class_name` inherits `EptGenericValidator::validateClassElement` (strict `^[a-zA-Z][a-zA-Z0-9_-]*$`).

`massageFormValues()` ensures each delta has an `ept_settings` array, then **flattens
`ept_settings['link_options']` up one level** (each key copied to `ept_settings[$key]`) so the primary
button's options are read at the top of `ept_settings` (matching the template's lookups). The
second-button options stay nested under `ept_settings['link_options2']`.

## Rendering — classes and the three style blocks
`templates/paragraph--ept-cta--default.html.twig`:
- Attaches `ept_basic_button/ept_basic_button_view` and `ept_cta/ept_cta`.
- Wrapper `<div>` classes include `paragraph`, `ept-paragraph`, `ept-basic-button`, `ept-cta`, the
  `styles` value (`two_columns` / `two_columns_fluid` / `one_column`), `image-position-<left|right>`,
  `align-content-<…>`, `ept-align-*`, `ept-shape-*`, `ept-size-*`, `ept-stretched`, and
  `paragraph-id-<id>` — all read from `content.field_ept_settings['#object'].field_ept_settings.0.ept_settings.*`.
- Two-column layouts (`two_columns` / `two_columns_fluid`) render `.column-1` (image) + `.column-2`
  (text + buttons); otherwise a single column. Each button is
  `<a class="ept-basic-button …" href="{{ content.field_ept_cta_link.0['#url'] }}">…</a>`, with
  `nofollow` / `target="_blank"` injected as pre-built strings via `|raw`. The second button
  (`ept-basic-button2`) renders only when `field_ept_cta_second_link` has content and gets
  `button2_classes` (align/shape/size/stretched).
- Ends with `{{ styles|raw }}` (ept_core `GenerateCSS` design output), `{{ button_styles|raw }}`
  (button colors, from `ept_basic_button.generate_custom_css`) and `{{ cta_styles|raw }}`
  (responsive columns, from `ept_cta.generate_cta_css`). See `agent/api/generate-css.md`.

## Notes for agents
- The module adds **no** routes, permissions, services beyond the CSS builder, config schema, or
  Drush. All configuration is per-paragraph on the Settings tab plus the site-wide ept_core form.
- To restyle, override `css/ept_cta.css` or the template in your theme; to change default breakpoint
  or colors, use ept_core's configuration form.
