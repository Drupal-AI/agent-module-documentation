TabPanelWidget Views adds a "TabPanelWidget" Views style that groups view rows by a field and renders each group as a responsive, accessible tab or accordion panel.

---

This submodule provides a single Views style plugin (id `tabpanelwidget_views`, class `Drupal\tabpanelwidget_views\Plugin\views\style\TabPanelWidget`, extending `StylePluginBase`). It uses row plugins and fields, requires exactly one grouping field (the group value becomes each tab/accordion header), and renders the rows of each group as that panel's body. The style's options form exposes the same TabPanelWidget settings as the base module (element level, behavior, tab style, tab options, accordion options), defaulting to the site-wide `tabpanelwidget.settings`, plus a "Use first row as default item?" checkbox controlling whether the first group is open on load. Rendering goes through `renderGroupingSets()`, which resets a `Tpw`, applies the options, and adds one item per grouping set. Because rows are produced by the normal Views row plugin, field and entity access are enforced by Views. It depends on both `tabpanelwidget` and `views`.

---

- Turn a grouped View into responsive tabs that collapse to an accordion on small screens.
- Group content by category/taxonomy term and show one tab per category.
- Build an FAQ View where each question group is an accordion header and its rows the answer.
- Display team members grouped by department, one tab per department.
- Show events grouped by month or year as tabbed panels.
- Present products grouped by type, each group in its own tab.
- Group articles by author and render each author's posts under an accordion header.
- Force a View to always render as horizontal tabs regardless of viewport.
- Force a View to always render as a stacked accordion.
- Choose the header element level (`h2`–`h5`) so the View's tab headers nest correctly under page headings.
- Apply "standard", "fancy", "pills", or "bar" tab styling to a View.
- Center or round the tabs generated from a View.
- Use disconnected, animated, or plus/minus accordion styling for a grouped View.
- Open the first group by default, or leave the whole accordion collapsed on page load ("Use first row as default item?" unchecked).
- Hide the grouping field from row output so the group label appears only as the tab header (per the form tip).
- Override the site-wide TabPanelWidget defaults on a per-View-display basis.
- Combine a contextual filter with tabbed grouping to show only relevant groups per page.
- Render an accessible, keyboard-navigable tabbed listing directly from Views without custom code.
