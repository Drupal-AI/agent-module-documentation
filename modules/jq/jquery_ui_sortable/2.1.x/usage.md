jQuery UI Sortable is a compatibility shim that re-supplies the jQuery UI Sortable asset library (`jquery_ui_sortable/sortable`) after it was deprecated and removed from Drupal core, so legacy themes and modules that reorder elements by drag-and-drop keep working.

---

Drupal core once shipped jQuery UI and exposed its Sortable widget as the `core/jquery.ui.sortable` library, but jQuery UI is end-of-life and core has progressively removed it. This module (together with the base `jquery_ui` module, which vendors the actual jQuery UI files) declares an empty `sortable` library in `jquery_ui_sortable.libraries.yml` that the `jquery_ui` module fills in at build time with the real `sortable-min.js` asset. It has no configuration UI, no `configure` route, no permissions, no services, no plugins, and no PHP API — its entire surface is the single asset library id `jquery_ui_sortable/sortable`. To use it you enable the module and change any reference from the removed `core/jquery.ui.sortable` to `jquery_ui_sortable/sortable`, either by attaching the library to a render array or by listing it as a dependency in a theme/module `*.libraries.yml`. The maintainers explicitly caution that jQuery UI is no longer maintained and recommend migrating away from it (core replaced Sortable with SortableJS) rather than adopting it for new code.

---

- Restore the `jquery_ui_sortable/sortable` library on a Drupal 10/11 site after core removed `core/jquery.ui.sortable`.
- Keep a legacy custom module that calls `.sortable()` working without rewriting its JavaScript.
- Keep a contributed theme that depends on jQuery UI Sortable functional on modern core.
- Attach the Sortable library to a render array via `$build['#attached']['library'][] = 'jquery_ui_sortable/sortable';`.
- Reference `jquery_ui_sortable/sortable` under `dependencies:` in a theme or module `*.libraries.yml`.
- Provide drag-and-drop reordering of list items in a custom admin UI.
- Enable sortable rows in a bespoke settings form that predates SortableJS.
- Migrate a Drupal 8/9 module to Drupal 11 where the only blocker is the missing core jQuery UI Sortable library.
- Supply Sortable for another contrib module that still declares a dependency on it.
- Attach the library site-wide from `hook_page_attachments()` in a custom module.
- Bridge a gap during an incremental migration from jQuery UI Sortable to SortableJS.
- Support connected sortable lists (drag items between two `<ul>`s) in legacy front-end code.
- Power a drag-to-reorder gallery or playlist widget in a custom block.
- Keep JavaScript that relies on Sortable events (`start`, `update`, `stop`) intact.
- Avoid bundling your own copy of jQuery UI by depending on the shared `jquery_ui` vendored assets.
- Reorder tabledrag-like custom widgets that were built on jQuery UI Sortable.
- Provide Sortable to a distribution/install profile that ships legacy front-end features.
- Satisfy a `core/jquery.ui.sortable` reference flagged by an upgrade-status / deprecation scan.
- Keep a third-party jQuery plugin that internally calls `.sortable()` working.
- Let a theme override a core template that expected the Sortable library to be present.
