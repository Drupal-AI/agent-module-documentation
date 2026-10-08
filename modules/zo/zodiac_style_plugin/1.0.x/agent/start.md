<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zodiac Style Plugin (zodiac_style_plugin) — agent index

Provides ONE Views **style plugin**, id `zodiac_style_plugin` (title "Zodiac"), that renders a
view's rows as a **carousel / slider** driven by the bundled `@librarymarket/zodiac` JS library.
Slider behaviour (autoplay, items-per-view, gap, transition/autoplay speed, infinite scroll, live
region, pause-on-hover) is configurable globally and, optionally, per core **breakpoint** — the
plugin turns each breakpoint's media query into a `mediaQueryOptions` entry passed to the JS.

Depends on core `breakpoint` and `views`. PHP >= 8.1. `core_version_requirement: ^10.1 || ^11`.
No settings page, no routes, no permissions, no services, no drush. Configured entirely from the
Views UI (needs the core `administer views` permission).

Solution docs:
- **Enable the style on a view + set slider options (defaults, per-breakpoint overrides, config YAML/PHP)** → [configure/options.md](configure/options.md)
- **How the Views style plugin renders, attaches the library, and hands settings to the JS** → [plugins/views-style.md](plugins/views-style.md)

Key facts:
- Plugin class `Drupal\zodiac_style_plugin\Plugin\views\style\Zodiac` extends `StylePluginBase`
  (`@ViewsStyle` id `zodiac_style_plugin`, `theme = "views_view_zodiac"`, `display_types {"normal"}`).
- Theme hook `views_view_zodiac` (declared in `zodiac_style_plugin_theme()`), template
  `templates/views-view-zodiac.html.twig` (prev/next buttons + `.zodiac-inner > .zodiac-track > .zodiac-item`).
- Asset library `zodiac_style_plugin/behavior`; JS `js/behavior.js` runs `new Zodiac(selector, settings).mount()`.
- Config schema key `views.style.zodiac_style_plugin` (settings stored inside the View, not a standalone config object).
- Base option keys: `autoplay`, `autoplaySpeed`, `enableLiveRegion`, `gap`, `infiniteScrolling`,
  `itemsPerView`, `liveRegionText`, `pauseOnHover`, `transitionSpeed`; plus `breakpoint_group` and `breakpoint_options`.
- Library assets ship under `node_modules/@librarymarket/zodiac/dist/` — referenced directly by
  `zodiac_style_plugin.libraries.yml`, so that path must stay deployed with the module.
