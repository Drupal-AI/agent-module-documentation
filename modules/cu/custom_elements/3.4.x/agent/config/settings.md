<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module settings & enabling rendering

## Settings form

Route `custom_elements.settings` → `/admin/config/system/custom-elements`, permission
`administer site configuration` (`SettingsForm`, config object `custom_elements.settings`).
This is the **only** route the main module defines. Menu link under System config.

Settings (schema `custom_elements.schema.yml`):
- **`markup_style`** — `web_component` (default) or `vue-3`. Slot/attribute syntax in markup
  output (see `api/rendering.md`).
- **`json_format`** — `explicit` (default; `{element, props, slots}`) or `legacy` (mixed at root;
  removed in 4.x). `custom_elements_update_9401` sets `legacy` on upgraded sites for BC.
- **`default_render_variant`** — `markup` or `preview:<provider_id>`. The default rendering mode
  for custom elements embedded in traditionally-rendered Drupal pages. Does **not** affect
  Lupus CE Renderer API responses or explicit preview renders (e.g. Canvas ExtJS).

Default install config (`config/install/custom_elements.settings.yml`): `markup_style: web_component`,
`json_format: explicit`.

## How rendering gets enabled

By default the module renders nothing on its own. Rendering an entity view into custom elements
happens when:

1. **Another module drives the API** — e.g. `lupus_ce_renderer` switches the main content renderer
   to emit custom-elements markup/JSON for whole pages (full decoupling); Lupus Decoupled Drupal
   packages this.
2. **Progressive decoupling per view mode** — enable "Force custom elements rendering" on a
   bundle/view-mode's *Manage Display* tab. This sets the `custom_elements` third-party setting
   `enabled` on the core view display. `custom_elements_entity_view_display_alter()` also
   auto-enables it for any view mode whose machine name starts with `custom_elements`. When enabled,
   the build array gets `#custom_elements_enabled`, and `custom_elements_entity_view_alter()`
   swaps `#theme` to `custom_element`. Attach your web-component JS/CSS to the
   `custom_elements/main` library (e.g. from a theme) — it is attached to every rendered element.

## Module weight & entity display class swap

`hook_install` / `custom_elements_update_8201` set module weight to 10 so it runs after
`layout_builder`. `custom_elements_entity_type_alter()` swaps the `entity_view_display` entity
class to `CustomElementsLayoutBuilderEntityViewDisplay` (if Layout Builder is on) or
`CustomElementsEntityViewDisplay`, guarding against a fatal during layout_builder's own install.

## Libraries (`custom_elements.libraries.yml`)

- `main` — empty by default; the extension point for progressive-decoupling front-end assets.
- `nuxt_app_loader`, `nuxt_preview` — used by the Nuxt preview provider.
