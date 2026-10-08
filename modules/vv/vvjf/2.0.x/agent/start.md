<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Vanilla Javascript 3D Flipbox - VVJF (vvjf) — agent index

Views **style plugin** (id `views_vvjf`) that renders a view's rows as an accessible, vanilla-JavaScript
grid of **3D flip cards** — no jQuery, no third-party library. Each row becomes one card: the **first
field** is the card **front**, the **remaining fields** are the **back**, split on a literal
`<div class="vvjf-separator"></div>` marker that the row template emits automatically between them. All
front-end behaviour runs inside a `<vvjf-flipbox>` custom element (`class VvjfFlipboxElement extends
ElementBase` from `vvj_core`) that lazy-hydrates via `IntersectionObserver`; the card flips on **click**
(default) or **hover**, with Enter/Space keyboard fallback, and ARIA `aria-hidden`/`tabindex` are kept in
sync with the flipped state. Options (dimensions, trigger, flip direction/axis, front/back background
colors, speed + easing, and a responsive breakpoint that gates the flip) are set **per view display in
the Views UI** — there is no site-wide settings page.

Almost all shared machinery — the options-form skeleton, `render()`, library attachment, token resolution,
unique-id generation — lives in the required **`vvj_core`** base plugin (`VvjStylePluginBase`); `vvjf`
contributes only the flipbox-specific options, five form sections, one breakpoint-CSS library selector,
and the locked plugin/theme names. v2.0 is a byte-compatible successor to 1.x: procedural hooks became OOP
`#[Hook]` attribute classes under `src/Hook/` (the `.module` file is a bootstrap stub), the outer tag
changed from `<div>` to `<vvjf-flipbox>`, and `supportsDeeplinking()` is FALSE (per-card state is transient
— nothing to deep-link to), but every option key, theme hook, template name, CSS class and the
`Drupal.behaviors.VVJFlipbox` behavior key stay unchanged. Upgrading auto-enables `vvj_core` via
`vvjf_update_10001`.

- Depends on: `drupal:views`, `drupal:filter`, `vvj_core:vvj_core` (shared foundation, pulled in by Composer).
- Core: `^11.3 || ^12`. PHP: **8.3+**. Package: `VVJ`. License: GPL-2.0-or-later. No Drupal 10 path.
- No routes, no permissions, no services of its own, no drush. Provides config schema. Configuration is per-view, so the `configure` route is `null`.
- Defines no plugin *type*; it provides one Views **style** plugin instance (`views_vvjf`) plus a `vvjf` token namespace. No custom `hook_help` page beyond README rendering, and (unlike the accordion) **no public `Drupal.vvjf.*` JavaScript API** — flip state is internal to the element.

## What you'd do → where

- **Enable the flipbox on a view and set its options (dimensions, trigger, direction, colors, speed/easing, breakpoint)** → [views/style.md](views/style.md)
- **Understand the option keys, config-schema key, defaults and bounds** → [views/style.md](views/style.md)
- **Theme the output, override the templates, or target CSS classes / custom properties** → [views/theming.md](views/theming.md)
- **Use `[vvjf:FIELD]` tokens in a view header / footer / empty text** → [api/tokens.md](api/tokens.md)
- **Understand the `<vvjf-flipbox>` custom element, its data attributes, breakpoint gating and a11y** → [api/javascript.md](api/javascript.md)

## Key facts (real machine names)

- Views style plugin: **`views_vvjf`** — `Drupal\vvjf\Plugin\views\style\Flipbox` (extends `vvj_core`'s `VvjStylePluginBase`). Config-schema key: `views.style.views_vvjf`. `display_types: ['normal']`, `theme: 'views_view_vvjf'`, `usesRowPlugin` = requires the **Fields** row plugin (enforced + validated: `"vvjf requires Fields as row style."`).
- Theme hooks (declared in `Hook\VvjfThemeHook`, names LOCKED for v1 parity): `views_view_vvjf` → template `templates/views-view-vvjf.html.twig`; `views_view_vvjf_fields` → `templates/views-view-vvjf-fields.html.twig`.
- OOP hook classes (registered by FQCN in `vvjf.services.yml`): `Hook\VvjfHelpHook` (`hook_help`, route `help.page.vvjf`, renders README.md), `Hook\VvjfThemeHook` (`hook_theme`), `Hook\VvjfPreprocessHooks` (`preprocess_views_view_vvjf`, `preprocess_views_view_vvjf_fields`, `preprocess_views_view`), `Hook\VvjfTokenHooks` (`hook_token_info`, `hook_tokens`; `@?vvj_core.token_resolver` injected nullable for the upgrade window).
- Token namespace: **`vvjf`** — `[vvjf:FIELD]` (rendered HTML via `Xss::filterAdmin`) and `[vvjf:FIELD:plain]` (HTML stripped). Delegated to `vvj_core.token_resolver`, passing `Flipbox::class`.
- Libraries (`vvjf.libraries.yml`): `vvjf/vvjf` (runtime JS `vvjf-flipbox-element.js` + `vvjf.js` shim, `css/vvjf.css`; depends on `core/drupal`, `core/drupal.ajax`, `core/drupalSettings`, `core/once`, and `vvj_core/tokens|base|a11y|element-base`), `vvjf/vvjf-style` (opt-in visual CSS, attached only when `enable_css`), and one of `vvjf/vvjf__all|576|768|992|1200|1400` (breakpoint media CSS, appended by `buildLibraryList()` from the chosen `available_breakpoints`).
- Custom element: `<vvjf-flipbox>` (`js/vvjf-flipbox-element.js`, `VvjfFlipboxElement extends ElementBase`, `static patternSlug = 'vvjf'`). Behavior key: `Drupal.behaviors.VVJFlipbox` (a `once()` marker only). Reads `data-flip-trigger` and `data-breakpoints` off the tag.
- Option keys (config schema `views.style.views_vvjf`): `flip_trigger`, `flip_direction`, `flip_speed`, `front_bg_color`, `back_bg_color`, `perspective`, `available_breakpoints`, `animation_easing`, `grid_gap`, `box_height`, `box_width`, `enable_css`, `unique_id`. **No** `enable_deeplink`/`deeplink_identifier` (deep-linking disabled) and **no** SVG-icon options.
- Constants: `Drupal\vvjf\VvjfConstants` (flipbox-only defaults + bounds; final, non-instantiable). Unique-id range (`10000000`–`99999999`) comes from `vvj_core`'s `ValidationBounds` via `vvj_core.unique_id_generator`.
- Update hook: `vvjf_update_10001` auto-installs `vvj_core` on 1.x → 2.x upgrade (`vvjf.install`).
- Optional config: `views.view.vvjf_example` (`config/optional/`) — demo view; its page display serves `/vvjf-example` gated by `access administration pages`.
