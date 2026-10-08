<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AT Tool is the module-side helper for the Adaptivetheme (AT) theme system on Drupal 10/11 — it wires up theme-developer conveniences like a LiveReload script, layout-settings CSS swapping on admin routes, appearance-page styling, and a breadcrumb-title lazy builder used by AT themes.

---

AT Tool exists to support Adaptivetheme and its sub-themes (installed via Composer as `drupal/adaptivetheme`); on its own it adds a small set of module-level features rather than any content or configuration UI. `at_tool_preprocess_system_themes_page()` attaches an `appearance_settings` CSS library to the Appearance page and adds a per-theme CSS class to each theme selector. `at_tool_library_info_alter()` reads the **active theme's** settings (`<theme>.settings` → `settings`) and, when the theme has developer mode + LiveReload enabled, injects a `livereload.js` script from `//localhost:<live_reload_port>` (default `35729`); on admin routes, when the theme's `layouts_enable` setting is on, it swaps in the correct layout-settings form stylesheet based on the theme's declared layout. It also registers a lazy-builder service (`at_tool.lazy_builders`, a `TrustedCallbackInterface`) whose `breadcrumbTitle()` returns a `page_title__breadcrumb`-themed render array for AT themes to place the current page title in the breadcrumb. The project ships theme **starterkits** (AT SKIN / STARTERKIT / the AT Theme Generator) — these are *themes*, not modules, and are not enabled as modules. AT Tool has no config entities, permissions, routes, or Drush commands of its own; its behavior is driven by the active Adaptivetheme sub-theme's theme settings.

---

- Provide the module-side support layer required by an Adaptivetheme sub-theme.
- Inject a LiveReload script during theme development for auto-refresh on save.
- Configure the LiveReload port via the active theme's `live_reload_port` setting.
- Swap in the correct layout-settings stylesheet on the theme's admin layout form.
- Style the Appearance page with the `appearance_settings` library.
- Add a per-theme CSS class to each theme selector on the Appearance page.
- Render the current page title inside the breadcrumb via a lazy builder.
- Give AT themes a `page_title__breadcrumb` render element to place the title.
- Enable theme developer mode features that depend on the active theme's settings.
- Support building sub-themes with the AT Theme Generator starterkit.
- Keep LiveReload/layout wiring out of the theme and in a shared module.
- Gate LiveReload injection behind the theme's `enable_devel` + `enable_live_reload` flags.
- Serve the layout form CSS that matches a theme's declared layout provider.
- Provide a trusted lazy-builder callback (`breadcrumbTitle`) for placeholdered rendering.
- Act as the Drupal 10/11 successor to the older AT Tools module.
- Pair with Adaptivetheme to build responsive, layout-configurable sub-themes.
- Attach appearance-settings styling only where the Appearance page needs it.
- Read theme settings to decide which developer libraries to load.
- Support layout-settings configuration in adaptive sub-themes on admin routes.
