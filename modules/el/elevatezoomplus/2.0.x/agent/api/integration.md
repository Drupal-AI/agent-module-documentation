<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blazy integration — hooks & service

ElevateZoom Plus has no plugin type and no public API of its own beyond the manager service; it works by
implementing Blazy's alter/build hooks (all in `elevatezoomplus.module`, delegating to
`ElevateZoomPlusManager`).

## Service
- `elevatezoomplus.manager` → `Drupal\elevatezoomplus\ElevateZoomPlusManager` (arg: `@blazy.manager`).
  Key methods used by the hooks: `libraryInfoAlter()`, `attachAlter()`, `formElementAlter()`,
  `buildAlter()`, `isApplicable()`, `preprocessBlazy()`, `getOptions()`, `config()`.
- Procedural shortcut `elevatezoomplus()` returns the manager (static-cached).

## Blazy/Slick/Splide hooks implemented
| Hook | Purpose |
|---|---|
| `hook_library_info_alter` | Point the `elevatezoomplus` library at the local `/libraries` copy. |
| `hook_blazy_attach_alter` | Attach the ez-plus asset library when the setting is on. |
| `hook_blazy_base_settings_alter`, `hook_config_schema_info_alter` | Register the `elevatezoomplus` setting on `blazy.settings` / `blazy_base`. |
| `hook_blazy_lightboxes_alter` | Register `elevatezoomplus` as a Blazy lightbox. |
| `hook_blazy_form_element_alter`, `hook_form_blazy_settings_form_alter` | Add the ElevateZoomPlus option to Blazy/formatter settings forms. |
| `hook_blazy_build_alter`, `hook_gridstack_build_alter`, `hook_slick_build_alter`, `hook_splide_build_alter` | Rewrite the render build to enable zoom. |
| `hook_blazy_settings_alter`, `hook_slick_settings_alter`, `hook_splide_settings_alter` | Force nav/count so Slick/Splide behave with asNavFor. |
| `hook_blazy_item_alter` | Switch non-image media to the `blazybox` lightbox. |
| `hook_preprocess_blazy`, `hook_preprocess_slick`, `hook_preprocess_splide` | Inject `data-initial-zoom` / zoom variables. |

## Theme
- `hook_theme` `elevatezoomplus` (`render element`, file `elevatezoomplus.theme.inc`).
  `template_preprocess_elevatezoomplus()` JSON-encodes the computed options into
  `attributes['data-elevatezoomplus']` for the JS.

You normally never call these directly — enabling the module + choosing the optionset on a Blazy display
is enough. To integrate a *custom* Blazy-based formatter, ensure your build carries the standard
`blazies` settings object so `isApplicable()` returns TRUE.
