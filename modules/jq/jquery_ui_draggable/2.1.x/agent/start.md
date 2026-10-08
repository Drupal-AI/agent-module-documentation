# jquery_ui_draggable — agent start

Provides the single asset library `jquery_ui_draggable/draggable`. No config, no
permissions, no services, no plugins. Depends on the `jquery_ui` module (which fills in
this module's empty `libraries.yml` stub at build time).

Usage: in your `*.libraries.yml` add a dependency on `jquery_ui_draggable/draggable`
(replacing any legacy `core/jquery.ui.draggable`), or attach it directly:
`$element['#attached']['library'][] = 'jquery_ui_draggable/draggable';`.

- Attach / depend on the library, migrate from `core/jquery.ui.draggable` → [api/attach-library.md](api/attach-library.md)

Note: jQuery UI is End of Life — use this as a compatibility bridge and plan a migration
to a modern drag-and-drop solution.
