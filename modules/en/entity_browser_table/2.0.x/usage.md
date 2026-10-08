Entity Browser - Table Layout adds a single Entity Reference field widget, "Entity Browser - Table", that renders the currently referenced entities as a sortable table (label/title, optional status, drag-and-drop weight, and edit/replace/remove actions) instead of Entity Browser's default grid/card layout.

---

The module is a thin extension of the [Entity Browser](https://www.drupal.org/project/entity_browser) module. It ships one field-widget plugin, `entity_reference_browser_table_widget` (class `EntityReferenceBrowserTableWidget`), that subclasses Entity Browser's `EntityReferenceBrowserWidget` and only overrides how the *current selection* is displayed: as a `#type => table` with tabledrag row weights rather than a grid of previews. It works on `entity_reference` and `entity_reference_revisions` fields and is chosen per field on the bundle's *Manage form display* page. All the normal Entity Browser widget settings (which entity browser to open, the field widget display, edit/remove/replace toggles, selection mode, open behaviour) still apply and are inherited from the parent widget; the only setting it adds is an "Additional Fields" checkbox for a **Status** column, which shows the entity's published status or, when Content Moderation is enabled and the entity is moderated, its moderation state. The first column is the field-widget-display output (usually "Entity label", or a thumbnail when using "Rendered entity"). The module exposes one alter hook, `hook_entity_browser_table_alter()`, to add extra columns/cells to the table, and attaches its own CSS/JS library plus core's `sortable` for drag ordering. It defines no settings form of its own, no routes, no permissions, no Drush commands, and `configure` is null.

---

- Display referenced nodes in a compact table (title + actions) instead of Entity Browser's card grid, to tidy up a busy edit form.
- Reference a large set of media items and let editors reorder them by dragging table rows.
- Show only the label of each referenced entity when the preview thumbnails are not useful.
- Add a Status column so editors can see at a glance which referenced entities are published or unpublished.
- Surface each referenced entity's Content Moderation state (draft/published/archived) in the widget's Status column.
- Swap an existing Entity Browser field to a table layout without changing the entity browser, view, or selection logic.
- Provide Edit / Replace / Remove buttons per row via the inherited Entity Browser widget toggles.
- Use on an `entity_reference_revisions` field (e.g. paragraphs-style references) that Entity Browser supports.
- Keep manual ordering of referenced entities using the tabledrag weight column, with a "Show row weights" toggle.
- Render a thumbnail column instead of a title by setting the field widget display to "Rendered entity".
- Curate a homepage "featured content" reference field as an ordered table of titles.
- Build an ordered list of related articles that editors can rearrange visually.
- Reference and order downloadable file entities in a table view.
- Add a custom column (e.g. content type, author, a field value) to the table with `hook_entity_browser_table_alter()`.
- Show the bundle/type of each referenced entity as an extra table column via the alter hook.
- Present translated labels of referenced entities in the current interface language (the widget loads the current-language translation).
- Configure via exported config: set the widget `type` to `entity_reference_browser_table_widget` in an `entity_form_display`.
- Reuse an existing entity browser (view/modal) but present its results in a table on the host form.
- Give editors a spreadsheet-like ordering UI for reference fields without writing a custom widget.
- Limit the Replace action to single-value selections (the widget only shows Replace when exactly one entity is referenced).
- Standardise reference-field editing UX across many content types by switching each field's widget to the table layout.
- Combine with the "Entity label" field widget display to show clean, linkless labels in the first column.
