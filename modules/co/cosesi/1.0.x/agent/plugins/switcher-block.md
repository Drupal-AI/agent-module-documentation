<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cosesi — switcher block & render elements

## Block plugin `cosesi_switcher`

`src/Plugin/Block/SwitcherBlock.php` (`#[Block(id: 'cosesi_switcher', admin_label: 'Color Scheme Switcher')]`,
extends `BlockBase`, `ContainerFactoryPluginInterface`). Injected service:
`ThemeSettings\ProviderInterface`. Place it via Block layout; standard block placement access applies.

`defaultConfiguration()` (see `defaultConfigurationSelf()`):
- `widget_type`: `buttons` (or `dropdown`).
- `buttons_settings` / `dropdown_settings`: each `{ show, states }`.
  - `show`: `icon` (default). `icon_label` / `label` / `label_icon` exist in the form but are marked
    `@todo Support these options in the Twig template` — only `icon` is fully rendered.
  - `states.{light,system,dark}`: `{ label, icon:{ pack_id: cosesi_solid, icon_id, settings:{ size } } }`.
    Default icons: light→`sun`, system→`sun-and-moon`, dark→`moon`; default size 14.

`buildConfigurationForm()` builds a Widget-type select plus Buttons and Dropdown `details`, each with a
`show` select and per-state fieldsets (`buildConfigurationFormStateElement()`: a `label` textfield and an
icon `size` number, min 8 / max 128 / step 1). `pack_id` and `icon_id` are `#type value` (fixed).
`submitConfigurationForm()` copies `widget_type`, `buttons_settings`, `dropdown_settings` from form state.

`build()` returns a render array of type `cosesi_switcher_{widget_type}` with `#show` and
`#cosesi_states` taken from the selected widget's settings.

Block config schema: `block.settings.cosesi_switcher` → `cosesi.switcher.widget_settings` for each of
`buttons_settings`/`dropdown_settings` (`config/schema/cosesi.schema.yml`). `show` is a `Choice`
constrained to icon/icon_label/label/label_icon.

## Render elements

Base `src/Element/SwitcherBase.php` (`RenderElementBase`, `ContainerFactoryPluginInterface`, DI:
`ThemeSettings\ProviderInterface`):
- `preRenderCosesiApi()` adds cache tag `config:cosesi.theme_settings`, pushes the API `<style>`/`<script>`
  entries into `#attached['html_head']` (via `Provider::getAttachedHtmlHeadEntries()`), and merges
  `#cosesi_states` over `defaultCosesiStates()`.
- `defaultCosesiStates()` defines the three states with `value` = `light` / `light dark` / `dark`
  and default sun/sun-and-moon/moon icons — the `value` is what the widget button submits to the JS API.

`cosesi_switcher_buttons` (`SwitcherButtons.php`): `#theme cosesi_switcher_buttons`, default `#show icon`;
`preRenderSelf()` attaches library `cosesi/switcher_widget_buttons`.

`cosesi_switcher_dropdown` (`SwitcherDropdown.php`): `#theme cosesi_switcher_dropdown`, default
`#show icon_label`; uses the HTML popover API (`popover`, `popovertarget`, `popovertargetaction`);
`preRenderSelf()` attaches `cosesi/switcher_widget_dropdown` and assigns a unique popover id
via `Html::getUniqueId()`.

## Theme hooks & templates

`src/Hook/ThemeHooks::theme()` registers both hooks. Templates:
- `templates/cosesi-switcher-buttons.html.twig` — a `<button name="colorScheme" value="{{ state.value }}">`
  per state, each rendering `icon(state.icon.pack_id, state.icon.icon_id, state.icon.settings)`.
- `templates/cosesi-switcher-dropdown.html.twig` — an opener button plus a popover `<div>` of trigger
  buttons; also renders `{{ state.label }}` next to each icon. All variables are Twig auto-escaped.

## Icon pack `cosesi_solid`

`cosesi.icons.yml` — `extractor: svg`, sources `assets/icons/solid/*.svg` (sun, sun-and-moon, moon),
default render size 20 with width/height/class/size settings. Consumed through core's icon API `icon()`.
