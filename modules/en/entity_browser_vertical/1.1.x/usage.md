<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Browser Vertical adds one "Entity label, stacked vertically" field-widget-display plugin to the Entity Browser module, so referenced items selected through an Entity Browser widget render in a vertical, drag-to-reorder list instead of side by side.

---

The module is a thin add-on for `entity_browser`. It ships a single Entity Browser `FieldWidgetDisplay` plugin, `entity_browser_vertical_label`, that subclasses Entity Browser's own `EntityLabel` display (so each referenced entity is shown by its label) and registers under the human label "Entity label, stacked vertically". You pick it in an entity-reference field's *Manage form display* by editing the Entity Browser widget's settings and choosing that display plugin. At form build time `hook_field_widget_complete_entity_browser_entity_reference_form_alter()` detects the chosen display, adds the `entity-browser-vertical` CSS class to the current-selection container, injects a `tabledrag-handle` anchor before each item, and attaches the module's small CSS library. The result mimics a lightweight tabledrag list (vertical stack with drag handles) rather than the default horizontal row of chips. It has no settings form, no configure route, no permissions, no Drush, and no plugin types of its own; its only persistent footprint is the `field_widget_display` value stored in the Entity Browser widget's component of an `entity_form_display` config entity.

---

- Show media items selected via an Entity Browser widget as a vertical list rather than a horizontal strip of thumbnails/labels.
- Give editors a drag-to-reorder handle on each referenced entity in an Entity Browser field.
- Simplify a long list of referenced entities so each sits on its own row for easier scanning.
- Replace the default side-by-side chip layout on a media reference field with a stacked label list.
- Improve usability of an image gallery reference field where many items overflow the horizontal container.
- Present referenced articles/nodes in an ordered, top-to-bottom column in the node edit form.
- Reorder referenced entities by dragging, similar to a tabledrag element, without a custom widget.
- Apply the vertical display only on specific form modes (e.g. the default form) by setting it per component.
- Standardise entity-reference selection UX across content types by choosing the same display plugin.
- Avoid the horizontal-scroll problem of Entity Browser's default current-selection layout.
- Show entity labels (not rendered previews) in a compact vertical list to save vertical space per item.
- Use it on a paragraphs or taxonomy reference field wired to an Entity Browser.
- Configure the layout entirely through exported config (`field_widget_display: entity_browser_vertical_label`) for deployment.
- Provide a cleaner reordering UI for editorial teams managing curated content lists.
- Serve as a lightweight stand-in for the unmerged Entity Browser tabledrag patch (issue 2973457).
- Keep the selection UI readable when referenced entities have long titles that would otherwise wrap awkwardly side by side.
- Toggle between horizontal and vertical selection display by switching the widget's display plugin.
- Style the vertical current-selection list with the module's shipped CSS (borders, flex rows, drag handle spacing).
- Roll out a consistent stacked selection UI across many entity-reference fields with one display-plugin choice.
- Use on a media library-style reference field where per-item ordering matters more than a gallery grid.
