jQuery UI Droppable re-provides the jQuery UI Droppable library as a contrib module after jQuery UI was deprecated and removed from Drupal core, so themes and modules that turn elements into drop targets keep working.

---

Drupal core historically bundled the jQuery UI Droppable interaction as `core/jquery.ui.droppable`, but jQuery UI is no longer actively maintained and has been marked End of Life by the OpenJS Foundation, so core deprecated and removed it. This module declares a single asset library, `jquery_ui_droppable/droppable`, whose contents are filled in by the base `jquery_ui` module (the `.libraries.yml` file ships an intentionally empty definition). Because a drop target only makes sense alongside draggable items, the module depends on both `jquery_ui` (>=8.x-1.7) and `jquery_ui_draggable` (>=2.1), and Composer requires `drupal/jquery_ui` and `drupal/jquery_ui_draggable`. There is no configuration UI, no permissions, no services and no plugins; you install it and attach the library where you need it. To migrate legacy code you swap `core/jquery.ui.droppable` references for `jquery_ui_droppable/droppable` in your theme or module. The module's `hook_help()` points to the jQuery UI deprecation change record (node/3067969) and the project page. The maintainers caution that jQuery UI is End of Life and recommend selecting a maintained replacement rather than adding new dependencies on it.

---

- Restore the jQuery UI Droppable interaction after upgrading to a Drupal core version where it was removed.
- Replace a `core/jquery.ui.droppable` library reference in a custom theme with `jquery_ui_droppable/droppable`.
- Replace a `core/jquery.ui.droppable` reference in a custom module's render array with `jquery_ui_droppable/droppable`.
- Keep a legacy contrib module that still uses jQuery UI droppable working without patching it.
- Attach `jquery_ui_droppable/droppable` as a `dependencies` entry in your own `*.libraries.yml`.
- Add the droppable interaction assets to a custom JS behavior that defines drop zones.
- Build a legacy drag-and-drop admin interface where items are dropped onto target areas.
- Provide drop targets for a jQuery UI draggable-based sortable or shopping-cart style widget.
- Pull in droppable together with `jquery_ui_draggable` for a complete drag-and-drop pairing.
- Avoid deprecation warnings by depending on `jquery_ui_droppable/droppable` instead of the core library.
- Support an old custom template that calls `.droppable()` on elements.
- Bridge a contributed module during migration away from jQuery UI to a modern drag-and-drop library.
- Let a distribution pin jQuery UI droppable as an explicit, maintained-in-contrib dependency.
- Ensure a consistent jQuery UI droppable version across a multisite platform.
- Enable file-upload or media widgets that rely on droppable drop zones from jQuery UI.
- Provide the droppable behavior for a legacy dashboard where widgets are rearranged by dropping.
- Keep a form element that accepts dropped values functioning after core deprecation.
- Supply droppable assets to a Views or Layout Builder customization that uses drop targets.
- Add droppable so a custom kanban-style board can accept cards into columns.
- Serve the droppable interaction to a front end without re-implementing it in a maintained library yet.
