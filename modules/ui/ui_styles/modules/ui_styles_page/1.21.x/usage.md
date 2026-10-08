<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Styles Page lets you attach curated CSS classes to a theme's regions (header, content, sidebars, footer, …) from a per-theme settings form, so every render of that region carries the chosen classes.

---

This submodule adds a *Regions styles* admin section under *Appearance*
(`/admin/appearance/regions-styles`, and `/admin/appearance/regions-styles/{theme}` per theme,
gated by the `administer themes` permission). The form (`RegionsThemeSettingsForm`) shows a
`ui_styles_styles` selector for each region declared by the chosen theme. Selections are saved
into that theme's settings config `<theme>.settings` under
`third_party_settings.ui_styles_page.regions.<region_name>` (each a
`ui_styles.selected_mapping` of `{selected, extra}`). A `PreprocessRegion` hook then reads the
setting for the region being rendered and merges the resulting classes onto the region's
`attributes`. A menu-task deriver (`RegionStyles`) generates a local task per theme. State is
purely theme settings; uninstall clears the keys.

---

- Add a container/max-width utility class to the main content region.
- Give the header region a background colour class site-wide.
- Apply spacing utilities to the footer region across all pages.
- Style sidebar regions consistently without editing `region.html.twig`.
- Add a sticky or shadow utility to the primary menu region.
- Apply different region styles per theme (e.g. admin vs front-end theme).
- Set text-alignment or flex utilities on a social-links region.
- Add responsive visibility classes to a highlighted region.
- Keep region styling in exported theme settings config for deployment.
- Brand the breadcrumb region with a subtle background.
- Apply a "section" padding class to the content-above region.
- Give the hero region a full-bleed utility class.
- Add a border-top utility to the footer to separate it visually.
- Apply consistent gutters to all content regions of a theme.
- Use the extra free-text field for a one-off region class.
- Standardise region appearance when switching design systems.
- Add a print-friendly utility class to a region.
- Style the secondary menu region distinctly from the primary.
- Roll out a new spacing scale to regions by editing one settings form.
- Apply a background-pattern utility class to a decorative region.
- Ensure regions inherit design-system classes shipped by the theme's styles.
