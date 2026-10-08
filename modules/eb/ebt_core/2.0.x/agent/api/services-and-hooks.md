<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Core services, hooks, and render plumbing

## Services

| Service | Class | Role |
|---|---|---|
| `ebt_core.generate_css` | `Services\GenerateCSS` | `generateFromSettings($design_options, $block_class)` → scoped CSS string keyed to a per-block class. |
| `ebt_core.generate_js` | `Services\GenerateJS` | `generateFromSettings($design_options)` → drupalSettings payload for parallax / background video behaviors. |
| (autowired) | `Hook\EbtCoreHooks` | OOP hook implementations (see below). |

`GenerateCSS` is constructed with `config.factory`, `theme.manager`, `file_url_generator`,
`entity_type.manager`; `GenerateJS` with `config.factory`, `media.oembed.url_resolver`,
`file_url_generator`, `entity_type.manager`.

## Constants & validators

- `Drupal\ebt_core\Constants\EbtConstants` — `COLOR_BLUE = '#0d77b5'`, `COLOR_WHITE = '#fff'`,
  `COLOR_BLACK = '#000'`.
- `EbtSettingsDefaultWidget::validateColorElement($element, $form_state, $form)` — static HEX
  color validator, reused by `EbtCoreSettingsForm`.
- `Helper\EbtGenericValidator::validateClassElement(...)` — CSS class validator.

## Hooks (`Hook\EbtCoreHooks`, `#[Hook(...)]`)

- `hook_help` — module help page.
- `hook_entity_presave` — fixes empty langcode on paragraph entities.
- `hook_theme` — registers the `ebt_settings_default` theme hook
  (template `ebt-settings-default`).
- `hook_theme_registry_alter` — for every enabled `ebt_*` module, registers
  `block__inline_block__<mod>`, `block__block_content__<mod>`,
  `field__block_content__field_<mod>__<mod>`, and (if Paragraphs is on)
  `paragraph__<mod>__default` theme entries pointing at that module's `templates/`.
- `hook_theme_suggestions_block_alter` / `hook_theme_suggestions_paragraph_alter` — add
  per-bundle `*--custom` template suggestions for `ebt_*` bundles.
- `hook_preprocess_block` — the render core: for a block whose bundle starts `ebt_`, reads
  `field_ebt_settings` → `design_options`, generates scoped CSS via `ebt_core.generate_css`
  (into `$variables['styles']`), builds JS behaviors via `ebt_core.generate_js`, and attaches
  the needed libraries (`ebt_core/ebt_styles`, `ebt_core/parallax`,
  `ebt_core/jquery_mb_ytplayer`, `ebt_core/vidbg`) plus breakpoint values into
  `drupalSettings.ebtCore`. Adds `ebt-edge-to-edge` / `ebt-width-<name>` classes.
- `hook_block_content_view` — passes each `ebt_*` block's settings to
  `drupalSettings` keyed by camelCase bundle + block revision id / uuid.

## Libraries (`ebt_core.libraries.yml`)

Local: `ebt_core` (JS), `ebt_settings` (CSS), `ebt_styles` (CSS), `ebt_colorpicker`.
External (need `/libraries/...`): `colorpicker` (jquery-colorpicker), `parallax` (parallaxjs),
`jquery_mb_ytplayer` (jquery.mb.YTPlayer), `vidbg`. These back the color picker and the
parallax / background-video block features.

## Extending

To give a **custom** `block_content` bundle the EBT design options: add a `field_ebt_settings`
FieldConfig (the storage ships with this module), set the form widget to
`ebt_settings_default`, and name the bundle with an `ebt_` prefix so the preprocess/theme hooks
apply (or reimplement the preprocess call yourself). New full EBT block-type modules are
normally scaffolded with `drush generate ebt:module` (the `ebt_core_starterkit` submodule).
