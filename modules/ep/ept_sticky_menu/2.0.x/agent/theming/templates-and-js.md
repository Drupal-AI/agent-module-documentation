<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Templates, hooks, JavaScript & libraries

## Hook class

`src/Hook/EptStickyMenuHooks.php` — autowired service (`ept_sticky_menu.services.yml`), invoked from
`ept_sticky_menu.module` via `#[LegacyHook]` wrappers.

- `themeRegistryAlter(&$theme_registry)` (`hook_theme_registry_alter`) — registers
  `paragraph__ept_sticky_menu_link__default` and `paragraph__ept_sticky_menu_links__default` against
  the module's `templates/` (base hook `paragraph`). The container
  `paragraph__ept_sticky_menu__default` is registered by **ept_core**'s own
  `hook_theme_registry_alter` (which auto-registers `paragraph--<ept_module>--default` for every
  enabled `ept_*` module).
- `preprocessParagraph(&$variables)` (`hook_preprocess_paragraph`) — see
  [../paragraphs/paragraph-types.md](../paragraphs/paragraph-types.md); computes `link_url`,
  `link_text`, `ept_link_settings` for `ept_sticky_menu_link` paragraphs.

## Templates (`templates/`)

- `paragraph--ept-sticky-menu--default.html.twig` (container): builds the wrapper `<div>`, adds the
  `sticky-js-block` class when `enable_sticky` is set, and emits `data-sticky-wrap`,
  `data-margin-top`, `data-sticky-for`, `data-sticky-class` (read from
  `content.field_ept_settings['#object'].field_ept_settings.ept_settings.*`). Prints
  `content|without('field_ept_settings','field_ept_title')`, then `{{ styles|raw }}`.
- `paragraph--ept-sticky-menu-links--default.html.twig` (dropdown group): plain EPT wrapper +
  content, then `{{ styles|raw }}`.
- `paragraph--ept-sticky-menu-link--default.html.twig` (link): renders
  `<a href="{{ link_url }}" class="{{ ept_link_settings.link_classes }}" [target=_blank] [rel=…]>{{ link_text }}</a>`.
  All values pass through Twig auto-escaping (no `|raw` on link fields); `styles|raw` prints
  ept_core-generated (escaped) CSS.

## JavaScript (`js/ept-sticky-menu.js`)

Four `Drupal.behaviors` (guarded with `core/once`), scoped to `.paragraph--type--ept-sticky-menu`:

- `eptStickyMenuScrollSpy` — an `IntersectionObserver` (`rootMargin: -50% 0 -50% 0`) toggles
  `is-active` on the `a[href^="#"]` whose target section is centered, and mirrors the active label
  into `.ept-mobile-toggle__label` via `textContent`.
- `eptStickyMenuScrollOffset` — intercepts anchor clicks, smooth-scrolls to the target minus menu
  height minus 10px, and `history.pushState`s the hash; also honors a hash present on page load.
- `eptStickyMenuBlocks` — instantiates `new Sticky('.sticky-js-block')` once (sticky-js watches
  scroll/resize globally).
- `eptStickyMenuMobileToggle` — injects a `role=button` hamburger `<span>` before
  `.field--name-field-ept-sticky-menu-links`, toggles `is-expanded`, closes on link tap below the
  960px breakpoint, and resets on resize to desktop.
- `eptStickyMenuDropdown` — for `.paragraph--type--ept-sticky-menu-links`, turns the parent link into
  an aria dropdown toggle (`is-dropdown-open`), with keyboard (Enter/Space/Escape) and
  outside-click-close on mobile.

Toggle markup is a static string assigned to `innerHTML`; dynamic text uses `textContent`.

## Libraries (`ept_sticky_menu.libraries.yml`)

Single library `ept_sticky_menu`: `css/styles.css`; JS `/libraries/sticky-js/dist/sticky.min.js`
(the external `levmyshkin/sticky-js` package, `^1.3`, installed to `/libraries/`) and
`js/ept-sticky-menu.js`; dependencies `core/drupal`, `core/once`. The library is attached from the
templates via `attach_library('ept_sticky_menu/ept_sticky_menu')`.

## Install / enable note

Enabling requires `ept_core` and `paragraphs` and the `ept_settings` field storage from ept_core;
if that dependency chain is absent the install can fail — the behaviour above is read from on-disk
source. `tests/src/Functional/InstallTest.php` covers a basic install.
