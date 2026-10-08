<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Styles Views adds a Views display extender that lets you apply curated UI Styles CSS classes to a view's exposed filter form, its result rows (style/format), and its pager.

---

This submodule registers a Views **display extender** plugin, `ui_styles` (class
`Plugin\views\display_extender\Styles`). On install it appends `ui_styles` to the
`display_extenders` list in `views.settings`, so the extender is available on every view
display. Its options form (`buildOptionsForm`) shows three `ui_styles_styles` selectors —
**Exposed form**, **Style** (the rows/format), and **Pager** — stored on the display under
`display_options.display_extenders.ui_styles.{exposed_form_options, style_options,
pager_options}` (each a `ui_styles.selected_mapping`). A `preprocess_views_view` hook then reads
the selected/extra classes for each section and injects them onto the corresponding template
variables (`$variables['exposed']`, `$variables['rows']`, `$variables['pager']`) via
`StylePluginManager::addClasses()`, handling grouped result sets. The pager selector is only
applicable when the display has a pager. No route, permission or settings page of its own.

---

- Add a wrapper class to a view's exposed filter form.
- Apply a grid or flex utility to a view's result rows.
- Style a view's pager with spacing or alignment classes.
- Give a listing view a card-grid layout via utility classes.
- Add a background/border to the exposed form area.
- Apply column-gap utilities to the rows region of a view.
- Standardise pager styling across multiple views.
- Add responsive visibility classes to exposed filters.
- Style rows differently per display (page vs block) of the same view.
- Keep view styling in the exported view config for deployment.
- Apply a max-width container class to a view's output section.
- Add alignment utilities to a horizontal exposed form.
- Give grouped result headers a consistent style.
- Apply a "list-unstyled" style to a rows region.
- Add margin utilities between the exposed form and results.
- Style a search view's pager as buttons.
- Reuse the design system's classes on views without templates.
- Apply a shadow utility to a featured view's rows.
- Add print-friendly classes to a view's output.
- Configure exposed-form, rows and pager styles from the Views UI.
- Ensure consistent view styling when switching front-end themes.
