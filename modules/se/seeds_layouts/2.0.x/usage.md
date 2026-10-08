<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Seeds Layouts adds framework-agnostic Layout Builder section layouts — one, two and three columns — whose configuration form is reorganised into Layout / Field / Advanced tabs so editors set responsive column widths, add configurable styling fields, and attach CSS classes and attributes without writing a plugin per project.

---

The three layouts (`seeds_1col`, `seeds_2col`, `seeds_3col`, all in the "Seeds" category) are thin: the intelligence is in the section settings form provided by the `SeedsLayout` plugin. The **Layout** tab exposes per-breakpoint (desktop / tablet / mobile) column-width choices whose options are not hard-coded but come from a *framework preset* — you import one (Bootstrap 3, Bootstrap 4, Foundation or Tailwind CSS ship in-module, or add your own) through the admin "Import a Framework" form, which populates `seeds_layouts.config` and the `seeds_layouts.columns` presets. It also offers a **reverse column order** checkbox and a **container / full-width** toggle. The **Field** tab renders "layout fields" — reusable, admin-defined field plugins attached to every section: `select` (adds one class picked from a `class|Label` list), `checkbox` (toggles a class), `background_image` (a Media/managed-file upload emitted as an inline `background-image` style, with parallax and repeat options), `wrapper` and `blocks_wrapper` (wrap a region's, or specific blocks', markup in a chosen HTML tag with classes/attributes), and `hide` (hides the section when empty). The **Advanced** tab lets editors type free-text attribute strings — in `key|value,key2|value2` form — onto the section, the columns parent, and each region. Beyond layouts, the module heavily re-themes Layout Builder, form and Media Library markup (via `--seeds-lb` template suggestions applied on Layout Builder routes and `libraries-extend` on the media library), adds preview thumbnails to the block/section browser through an `image_path` third-party setting, styles the choose-block/section dialogs, and can restrict which blocks non-privileged editors may place. Global configuration lives at `/admin/config/content/seeds_layouts` (Settings / Columns / Import tabs) behind the restricted "Administer Seeds Layouts" permission. The optional `seeds_layouts_classes_extractor` submodule bridges to the `classes_extractor` module so classes stored in config survive utility-CSS purging. Depends on core `layout_discovery` and `layout_builder`; version 2.0.22 on core `^10 || ^11`. Part of the Seeds toolkit by Sprintive.

---

- Add reusable one/two/three-column Layout Builder sections that are not tied to one CSS grid.
- Give editors per-breakpoint column-width control (different split on desktop vs tablet vs mobile).
- Reverse the visual order of columns without changing content order.
- Toggle a section between a constrained container and full width.
- Import a Bootstrap 3/4, Foundation or Tailwind column preset instead of hand-writing grid classes.
- Define a custom column preset for a bespoke theme's grid via the Columns admin form.
- Let editors pick a color/spacing/utility class from a curated select list per section.
- Offer a checkbox that toggles a specific utility class (e.g. hide, d-none) on a section.
- Add a background image (with parallax and repeat) to a Layout Builder section.
- Wrap a region's blocks, or a hand-picked subset of blocks, in a custom HTML element with classes.
- Automatically hide a section when all its blocks are empty.
- Attach arbitrary CSS classes / data-attributes to a section, its columns parent, or a single region.
- Curate the block list so non-privileged editors only see content/webform blocks (needs layout_builder_restrictions).
- Show preview thumbnails for block types and view modes in the Layout Builder browser.
- Restyle the Layout Builder add-block / choose-section dialogs and Media Library UI to match a design system.
- Keep only Seeds layouts visible in the choose-section list, hiding core's defaults.
- Provide a common layout vocabulary across many sites in a distribution.
- Standardise section markup so a theme's Twig/CSS can target predictable wrappers.
- Keep utility classes emitted only from config discoverable by a Tailwind/PurgeCSS build (classes extractor submodule).
- Repoint the "Layout" tab of a translated entity at its source-language layout for consistent editor access.
- Serve as an alternative to Bootstrap Layouts, Foundation Layouts, Layout Section Classes and Layout Builder Styles combined.
