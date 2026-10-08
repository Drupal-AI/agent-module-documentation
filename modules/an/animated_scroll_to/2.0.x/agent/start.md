<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Animated Scroll To (animated_scroll_to) — agent index

Client-side smooth scrolling. Animates the page (via jQuery `$('html,body').animate()`)
to a target element instead of jumping: for clicks on same-page anchor links, and for
page loads whose URL carries one or more `#fragment` targets. No third-party JS is bundled —
it uses core jQuery and its built-in `swing`/`linear` easings.

- Core only (`^9 || ^10 || ^11`); no module dependencies, no composer requirements.
- Configure route: `animated_scroll_to.settings` → `/admin/config/animate-scroll-to/settings`.
- Defines 1 permission, no drush commands, no plugins, no config schema, no entities, no submodules.
- Nothing runs until you enable at least one functionality on the settings form (config is
  empty on install, so `hook_preprocess_page` attaches neither library by default).

Solution docs:
- **Set default speed / delay / offset / easing and turn the two behaviors on** → [configure/settings.md](configure/settings.md)
- **Override per element via `data-scroll-*` attributes and style the `data-scroll-state` phases** → [theme/behavior.md](theme/behavior.md)
- **The one admin permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object: `animated_scroll_to.settings`. Keys: `delay`, `default_speed`, `default_pause`,
  `default_correction`, `default_easing` (`swing`|`linear`), plus toggles `on_page_load`,
  `in_page`, `in_page_links_use_delay`.
- Libraries: `animated_scroll_to/in_page` (js/animated-scroll-to-in-page.js),
  `animated_scroll_to/on_page_load` (js/animated-scroll-to-on-page-load.js); each depends on
  `core/jquery`, `core/drupal`, `core/drupalSettings`.
- Attach point: `animated_scroll_to_preprocess_page()` in `.module` — attaches a library +
  `drupalSettings.animated_scroll_to.default_settings` when the matching toggle is `=== 1`.
- Permission: `administer animated scroll to`. Route form: `\Drupal\animated_scroll_to\Form\AnimatedScrollToForm`.
- In-page link selector: `a[href^="#"]:not([href="#"]):not([data-toggle])`.
