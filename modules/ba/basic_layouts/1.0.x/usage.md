<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Basic Layouts adds five simple column layout plugins (one/two/three/four column plus a one-column grid) to Layout Builder, each with an optional formatted intro-text region.

---

Basic Layouts is a small, purely presentational module that registers five YAML-declared layout plugins for Drupal's Layout API: `one_column`, `one_column_grid`, `two_column`, `three_column`, and `four_column`. All five share one plugin class, `Drupal\basic_layouts\Plugin\Layout\BasicLayout`, which extends core `LayoutDefault` and adds a per-section option to display formatted "intro" text above the regions. The intro is entered through a core `text_format` element and rendered through Drupal's text-format filter pipeline (`#type => processed_text`). A single admin settings form (`basic_layouts.settings`, config route `basic_layouts.basic_layouts_config` at `/admin/config/content/basic-layouts-config`) exposes one flag, `unset_core_layouts` (default TRUE), which — via `hook_plugin_filter_layout__layout_builder_alter` — removes core's `layout_onecol`, `layout_twocol_section`, `layout_threecol_section`, and `layout_fourcol_section` from the Layout Builder picker so only the Basic Layouts variants show. The module depends only on core `layout_discovery` and ships templates plus a small `css/styling.css` (the `basic_layouts/layout` library). It has no entities, no permissions, no services, and no state-changing routes beyond the admin config form (gated by `administer site configuration`).

---

- Add extra column layouts to Layout Builder beyond core's defaults.
- Provide a one-column section layout (`one_column`).
- Provide a one-column grid variant (`one_column_grid`).
- Provide a two-column section layout (`two_column`, regions first/second).
- Provide a three-column section layout (`three_column`, regions first/second/third).
- Provide a four-column section layout (`four_column`, regions first/second/third/fourth).
- Show an optional formatted intro paragraph above a section's columns.
- Let editors toggle the intro text per section with the "Display text at the top of the section" checkbox.
- Enter intro copy through a full-HTML-capable text-format editor.
- Hide core's onecol/twocol/threecol/fourcol section layouts so only Basic Layouts appear.
- Re-enable core layouts by unchecking "Unset core layouts?" at the settings form.
- Enable or disable the layouts per content type in Manage Display.
- Pair with Layout Builder Styles to add classes/styles to sections.
- Pair with Layout Builder Sections Config for extra section settings.
- Group blocks/fields into consistent multi-column arrangements on node displays.
- Build landing-page sections with a heading intro and columned content.
- Standardize section markup with predictable `layout--onecol`/`--twocol`/etc. classes.
- Theme the columns via the shipped `css/styling.css` or override the Twig templates.
- Use the layouts anywhere the core Layout API renders layouts, not only Layout Builder.
- Give site builders a lightweight alternative to heavier layout suites.
- Keep the Layout Builder layout list uncluttered on multilingual/enterprise sites.
- Provide a default region (`content` or `first`) so blocks land sensibly.
