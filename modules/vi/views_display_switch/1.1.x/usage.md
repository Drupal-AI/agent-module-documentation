<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Display Switch provides a Views **area handler** ("Display switch") you drop into a view's header or footer that renders a set of links letting the visitor switch between the view's displays (e.g. a grid page and a table page, or two blocks) while preserving the active exposed-filter, pager and contextual-filter state.

---

The module registers a single Views area plugin (`@ViewsArea("display_switch")`) plus a `views_display_switch` theme hook and template. You add the *Display switch* area to a view's header or footer, then in its options tick the displays you want links for and give each a label. Only **path-based (page) displays** and **block displays** are eligible; the plugin warns (but does not block) if a linked display uses different filter/sort/pager/contextual-filter settings than the current one, since mismatched settings would give the user a different result set. For page displays it links to the target display's own path; for block displays (which have no path) it links to the current path with a `?mode=<display_id>` query parameter, and `hook_views_pre_view()` reads that `mode` parameter to switch the rendered display in place. Current exposed input and the current pager page are copied onto every generated link so the visitor keeps their filters and page position. The active display's link gets a `views-display-switch__link--active` class for styling. There is no global settings page (`configure` is null) and no permissions — everything is configured per view. Note the documented limitation: it assumes a single view on the page, and mixing page and block display types on one page can behave unexpectedly.

---

- Add a "Grid / List" toggle to a catalog view backed by two displays.
- Switch between a table page and a card/grid page of the same content.
- Offer a "Map view / List view" switch across two path-based displays.
- Let users flip between two block displays embedded on the same page via `?mode=`.
- Keep the visitor's exposed filter selections when they switch displays.
- Preserve the current pager page across a display switch.
- Preserve contextual filter arguments when linking to a page display.
- Provide a compact display switcher in a view's header area.
- Provide the switcher in a view's footer instead of the header.
- Give each display link a custom, human-friendly label.
- Highlight the currently active display with the `--active` CSS class.
- Build a "summary vs detailed" report toggle on a dashboard view.
- Switch a block-based listing placed via Layout Builder or Paragraphs without a page display.
- Style the switch links with the `views-display-switch` template override.
- Warn site builders at config time when linked displays have mismatched filter/sort/pager settings.
- Add a display switcher to a view that has both a page and additional page displays.
- Let editors preview the same results in two different Views styles.
- Provide quick navigation between "Upcoming" and "Past" event displays.
- Offer a "Compact / Comfortable" density switch backed by two displays.
- Reuse a single view's data across multiple presentation displays with one switcher.
