<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Vanilla Javascript Accordion - VVJA (vvja) — agent index

Views **style plugin** (id `views_vvja`) that renders a view's rows as an accessible,
vanilla-JavaScript accordion — no jQuery, no third-party library. The **first field** of each row
becomes the panel trigger (a `<button>`, or an `<a>` in deep-link mode); the remaining fields render
into the collapsible pane. All front-end behaviour runs inside a `<vvja-accordion>` custom element
that lazy-hydrates via `vvj_core`. Options (single/global toggles, exclusive mode, animation, layout
spacing, custom SVG icons, deep linking) are set **per view display in the Views UI** — there is no
site-wide settings page. Almost all shared machinery — the options-form skeleton, `render()`,
deep-link validation, SVG sanitizing, token resolution, unique-id generation — lives in the required
**`vvj_core`** base module; `vvja` contributes only the accordion-specific options, form sections and
the locked plugin/theme names.

v2.0 is a modernized, byte-compatible successor to 1.x: procedural hooks became OOP `#[Hook]`
attribute classes under `src/Hook/` (the `.module` file is a stub), while every plugin id, option
key, theme hook, template name, CSS class, JS behavior key and `Drupal.vvja.*` API stays unchanged.
Upgrading auto-enables `vvj_core` via `vvja_update_10001`.

- Depends on: `drupal:views`, `drupal:filter`, `vvj_core:vvj_core` (shared foundation, pulled in by Composer).
- Core: `^11.3 || ^12`. PHP: **8.3+**. Package: `VVJ`. License: GPL-2.0-or-later. No Drupal 10 path.
- No routes, no permissions, no services, no drush of its own. Provides config schema. Configuration is per-view, so the `configure` route is `null`.
- Defines no plugin *type*; it provides one Views **style** plugin instance (`views_vvja`) plus a `vvja` token namespace.

## What you'd do → where

- **Enable the accordion on a view and set its options (toggles, animation, layout, exclusive mode, deep linking, SVG icons)** → [views/style.md](views/style.md)
- **Understand the option keys, config-schema key, defaults and validation rules** → [views/style.md](views/style.md)
- **Theme the output, override the templates, or target CSS classes / custom properties** → [views/theming.md](views/theming.md)
- **Use `[vvja:FIELD]` tokens in a view header / footer / empty text** → [api/tokens.md](api/tokens.md)
- **Drive the accordion from your own JavaScript, deep-link to a panel, or read the data attributes** → [api/javascript.md](api/javascript.md)

## Key facts (real machine names)

- Views style plugin: **`views_vvja`** — `Drupal\vvja\Plugin\views\style\Accordion` (extends `vvj_core`'s `VvjStylePluginBase`). Config-schema key: `views.style.views_vvja`. `display_types: ['normal']`, `usesRowPlugin` = requires the **Fields** row plugin (enforced + validated).
- Theme hooks (declared in `Hook\VvjaThemeHook`, names LOCKED for v1 parity): `views_view_vvja` → template `templates/views-view-vvja.html.twig`; `views_view_vvja_fields` → `templates/views-view-vvja-fields.html.twig`.
- OOP hook classes (registered by FQCN in `vvja.services.yml`): `Hook\VvjaHelpHook` (`hook_help`, route `help.page.vvja`, renders README.md), `Hook\VvjaThemeHook` (`hook_theme`), `Hook\VvjaPreprocessHooks` (`preprocess_views_view_vvja`, `preprocess_views_view_vvja_fields`, `preprocess_views_view`), `Hook\VvjaTokenHooks` (`hook_token_info`, `hook_tokens`).
- Token namespace: **`vvja`** — `[vvja:FIELD]` (rendered HTML via `Xss::filterAdmin`) and `[vvja:FIELD:plain]` (HTML stripped). Delegated to `vvj_core.token_resolver`.
- Libraries: `vvja/vvja` (runtime JS+CSS), `vvja/vvja-style` (opt-in visual CSS, attached only when `enable_css`), `vvja/vvja-admin` (Views-UI admin JS/CSS).
- Custom element: `<vvja-accordion>` (`js/vvja-accordion-element.js`). JS API: `Drupal.vvja.{openPanel,closePanel,togglePanel,getOpenPanels,getTotalPanels,getInstance}` (`js/vvja.js`). Behavior key: `Drupal.behaviors.VVJAccordion`.
- Option keys (config schema `views.style.views_vvja`): `single_toggle`, `global_toggle`, `exclusive_panel`, `expand_default` (`none|first|all`), `animation` (`none|a-top|a-bottom|a-left|a-right|a-zoom|a-fade`), `transition_speed` (`0.1`–`2.0`), `accordion_item_width`, `pane_padding`, `panel_gap`, `enable_css`, `enable_deeplink`, `deeplink_identifier`, `svg_expand_content`, `svg_collapse_content`, `svg_expand_all`, `svg_collapse_all`, `unique_id`.
- Constants: `Drupal\vvja\VvjaConstants` (expand values + accordion defaults). Shared bounds in `vvj_core`'s `ValidationBounds`: transition speed `0.1`–`2.0`, deeplink identifier ≤ 20 chars, reserved deeplink words `accordion|panel|vvja|vvj`, unique-id range `10000000`–`99999999`.
- Update hook: `vvja_update_10001` auto-installs `vvj_core` on 1.x → 2.x upgrade.
- Optional config: `views.view.vvja_example` (`config/optional/`) — demo view; its page display serves `/vvja-example` gated by `access administration pages`.
