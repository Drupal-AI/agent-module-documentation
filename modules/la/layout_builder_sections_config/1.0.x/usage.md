<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Sections Config extends Layout Builder's "Configure section" form with extra fields so you can show a section's administrative label to end users (with a chosen HTML wrapper, position and colour) and add a custom HTML `id` and CSS classes to the section.

---

The module alters the core `layout_builder_configure_section` form (via
`hook_form_FORM_ID_alter`) to add six fields to every section: **Show section title to end
users** (a checkbox), **Title wrapper** (`h1`–`h6`), **Title position**, **Title color**, an
HTML **ID**, and a **Classes** textarea (one class per line). The option lists for wrapper,
position and colour are themselves configurable at
`/admin/config/content/layout-builder-sections-config` (route
`layout_builder_sections_config.settings`, permission `administer site configuration`) as three
newline-separated `key|Label` strings stored in `layout_builder_sections_config.settings`
(`title_wrappers`, `title_positions`, `title_colors`). A custom submit handler (unshifted before
core's) writes the chosen values into the section's own layout configuration under a
`layout_builder_sections_config` key. At render time `hook_preprocess_layout()` reads that
per-section config and, when "show title" is on, injects a `content.title` render array
(label + wrapper + position/colour classes), sets the section wrapper's `id`, and merges the
extra classes onto the section's attributes. The module also overrides the core layout
templates (`layout--onecol`, `layout--twocol-section`, `layout--threecol-section`,
`layout--fourcol-section`, plus a generic `layout`) and ships matching CSS so the title and
classes actually render; you may need to port these overrides into your own theme. It defines
no permissions of its own, no plugins, and no Drush commands.

---

- Display a Layout Builder section's admin label ("Hero", "Sidebar") to site visitors.
- Wrap a shown section title in a chosen heading tag (`h2`, `h3`, …) for correct document outline.
- Position a section title left, center, or right using the provided position classes.
- Colour a section title (black/white/blue by default) via the configurable colour list.
- Add a stable HTML `id` to a section so you can deep-link or target it with anchors.
- Attach custom CSS classes to a section wrapper for bespoke styling.
- Give editors a curated dropdown of allowed title wrappers instead of free text.
- Define your own title colour palette by editing `title_colors` (`key|Label` per line).
- Define custom title position options (e.g. justified) in `title_positions`.
- Restrict which heading levels are offered as section title wrappers.
- Build landing pages where each section shows a visible, styled heading.
- Add a scroll-target `id` to a "Contact" section for an on-page nav link.
- Apply a utility/background class to a section without a custom layout plugin.
- Standardise section heading styles across a site through configuration.
- Provide themers ready-made layout template overrides to copy into a custom theme.
- Add multiple classes to one section (one per line) for combined styling.
- Show the same admin label used in the Layout Builder UI to end users for consistency.
- Let content authors toggle a section heading on or off per section.
- Theme section titles with your own CSS by targeting the injected classes.
- Give marketing sections an anchor `id` for campaign links.
- Reuse the module's onecol/twocol/threecol/fourcol template overrides as a starting point.
- Configure heading semantics per section for accessibility (logical heading order).
- Add data/utility classes to sections to integrate with a CSS framework.
- Turn Layout Builder's internal section labels into visible, styled page headings.
