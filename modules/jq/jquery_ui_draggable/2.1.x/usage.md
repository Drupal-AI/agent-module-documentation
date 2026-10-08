jQuery UI Draggable ships the standalone `jquery_ui_draggable/draggable` asset library so themes and modules can keep using jQuery UI's draggable behavior after it was deprecated and removed from Drupal core.

---

Drupal 8 bundled jQuery UI in core, but jQuery UI is no longer actively maintained and has been marked End of Life, so core deprecated and progressively removed its jQuery UI assets. This contrib module restores just the Draggable component as a self-contained asset library named `jquery_ui_draggable/draggable`. It depends on the `jquery_ui` base module, which supplies the underlying jQuery UI core files; this module's own `libraries.yml` is an intentionally empty stub that the `jquery_ui` module fills in at build time. There is no configuration UI, no permissions, no services, and no plugins — it exists purely to provide the library asset. Developers migrate by swapping any `core/jquery.ui.draggable` dependency for `jquery_ui_draggable/draggable` in their theme's or module's `*.libraries.yml` and attaching it with `#attached`. Because jQuery UI is End of Life, the maintainers recommend treating this as a compatibility bridge and moving to a modern drag-and-drop solution over time. It belongs to the family of per-component jQuery UI modules (Accordion, Button, Droppable, Slider, and so on) that each carve out one widget from the retired core library.

---

- Restore the jQuery UI Draggable behavior after it was removed from Drupal core.
- Provide the `jquery_ui_draggable/draggable` library to a custom theme.
- Provide the draggable library to a custom module that needs drag interactions.
- Make a custom admin UI panel draggable around the screen.
- Build a draggable dialog or modal window in a contrib/custom module.
- Add drag-to-reposition behavior to a dashboard widget.
- Let editors drag preview overlays or floating toolbars in a content workflow.
- Reposition a custom help or onboarding popover by dragging it.
- Enable drag handles on items in a custom list or grid widget.
- Attach draggable to elements via a Drupal library dependency in `*.libraries.yml`.
- Pair with jQuery UI Droppable to build drag-and-drop upload or sorting zones.
- Support a legacy module that still references `core/jquery.ui.draggable`.
- Keep a third-party theme working on Drupal 10/11 after the core deprecation.
- Prototype a draggable image or map hotspot editor in the admin.
- Move a floating live-preview window while editing a node.
- Drag color/position pickers in a custom field widget.
- Build a draggable split-pane or resizable-panel admin layout helper.
- Let users rearrange draggable cards on a personalized landing page.
- Provide draggable behavior for a custom Views or Layout Builder UI enhancement.
- Attach the library programmatically with `$element['#attached']['library'][]`.
- Offer a drag-to-annotate tool over media in a moderation workflow.
- Give a custom JavaScript component access to jQuery UI's `.draggable()` API.
- Bridge to jQuery UI Draggable during a gradual migration to a modern JS drag library.
