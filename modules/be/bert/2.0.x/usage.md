Better Entity Reference Table (bert) replaces the default entity-reference form widget with a sortable, removable table plus a configurable add-control and a companion selection handler.

---

BERT ("Better Entity Reference Table") ships one field widget (`bert`, for any `entity_reference` field) that renders the referenced entities as an editable table: each row shows a configurable list-formatter cell, an optional Remove button, and (for multi-value fields) a drag-and-drop weight handle. New references are added through a Select dropdown, Radios, or an Autocomplete box. It also provides a custom entity-reference selection handler (`bert:*`, one derivative per entity type) that adds options the core handler lacks — a label-formatter for search results, a result limit, same-language-only filtering, published-only filtering, and the ability to exclude the parent entity. Selecting the bert widget on a field's form display automatically switches that field's reference method to the matching `bert:<entity_type>` handler. Two extensible plugin types (list formatters and label formatters, discovered under `Plugin/bert/…` with alter hooks) let modules add custom cell/label rendering. The module has no routes, no permissions, no admin settings page, and no Drush commands — everything is configured on the field's *Manage form display* and *field edit* pages.

---

- Replace the default entity-reference autocomplete/select widget with a clearer table that shows every referenced entity at a glance.
- Give editors an obvious per-row **Remove** button (the core widget has no easy way to remove an already-added item).
- Let content editors reorder multi-value references by drag-and-drop weight handles.
- Turn off drag-and-drop reordering when reference order should stay fixed (*Disable drag and drop*).
- Choose how each referenced entity is displayed in the table: title only, title + bundle, title + publishing status, or title linked to its edit form.
- Add references with a **Select** dropdown when the option set is small.
- Add references with **Radios** when you want all options visible at once as single-choice buttons.
- Add references with an **Autocomplete** field when the referenceable set is very large.
- Set a custom placeholder on the autocomplete/select add-control (*Add entities placeholder*).
- Prevent the same entity from being referenced twice in one field (*Disable duplicate selection*, on by default).
- Hide the Remove button to make a reference list read-only-ish once populated (*Disable remove*).
- Wrap (or unwrap) the widget in a fieldset with a legend (*Add a wrapper (fieldset)*).
- Limit how many autocomplete/select suggestions are offered per field (*Number of results*, 0 = unlimited).
- Restrict suggestions to entities in the current content language (*Same language only*).
- Restrict suggestions to published entities only, when the target type has a publishing flag (*Published only*).
- Stop a field from referencing the very entity it is attached to (*Disable selection of parent entity*, e.g. a "related articles" field on a node not listing itself).
- Sort autocomplete/select suggestions by the entity **label** rather than by a specific storage field (`_label` sort option).
- Auto-create referenced entities on the fly from the autocomplete box when the field's core handler has autocreate enabled (nodes are auto-published so they become referenceable).
- Provide a custom table cell renderer by declaring an `EntityReferenceListFormatter` plugin in your own module.
- Provide a custom search-result label by declaring an `EntityReferenceLabelFormatter` plugin.
- Swap out or subclass a built-in formatter's class via `hook_bert_entity_reference_list_formatter_alter()` / `hook_bert_entity_reference_label_formatter_alter()`.
- Migrate an older site from the legacy `wmbert` module — enabling `bert` rewrites `wmbert` widgets/handlers and uninstalls the old module automatically.
- Use it on any content entity reference field (nodes, taxonomy terms, media, users, custom entities) since the selection handler is derived per entity type.
