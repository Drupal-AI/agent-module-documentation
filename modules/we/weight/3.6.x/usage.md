Weight provides a `weight` field type that can be added to any fieldable entity so its records can be manually ordered rather than sorted by title or date.

---

Weight adds a single field type, `weight`, that stores a signed integer in the database and can be attached to any fieldable entity (content types, taxonomy terms, custom entities, etc.) through the normal **Manage fields** UI. Each field has a **Range** setting (default `20`): the widget then offers a select list of every integer from `-range` to `+range`, so a range of `20` lets an editor pick any weight from `-20` to `20`. The default widget is the **Weight Selector** (`weight_selector`), a plain `<select>` of the available weights; the default formatter is core's `number_integer`, and the module also ships a minimal `default_weight` formatter that prints the raw value. To actually change display order you sort a View (or any query) ascending by the weight field's value. The module also integrates with Views: it exposes a **Weight Selector** Views field handler and a `hook_preprocess_views_view_table()` that turns a table View containing that handler into a drag-and-drop (tabledrag) reorder form, saving new weights back to each entity on submit. A storage-level **Unsigned** setting can restrict values to non-negative integers. Beyond field, widget, formatter, Views handler, a D7 migrate field plugin, and a Feeds target, the module defines no services, routes, permissions, or plugin types of its own.

---

- Add a "Weight" field to a content type so editors can manually order nodes.
- Manually order taxonomy terms by attaching a weight field to a vocabulary.
- Manually order custom or contrib fieldable entities that lack built-in ordering.
- Order a list of promoted/featured items by assigning explicit weights.
- Set a field **Range** of `20` to allow weights from `-20` to `20`.
- Use a larger range (e.g. `100`) when you need finer-grained ordering of many items.
- Present editors a simple select-list weight picker via the Weight Selector widget.
- Sort a View ascending by the weight field's `_value` to render items in chosen order.
- Build a drag-and-drop reorder screen by adding the Weight Selector field to a table View.
- Reorder rows by dragging in a Views table, saving new weights to every entity at once.
- Reorder items within Views grouping, where each group becomes its own draggable table.
- Restrict a weight field to non-negative values with the storage **Unsigned** setting.
- Display the stored weight value using core's `number_integer` formatter.
- Hide the weight value from public display while still using it only for sorting.
- Give a "menu-like" manual sort to entities that are not menu links.
- Order blocks, cards, or teasers rendered through a View by weight.
- Let content editors fine-tune ordering without touching code or config.
- Provide a per-language weight, since the Views reorder form saves to the row's translation.
- Migrate Drupal 7 weight field data using the bundled D7 migrate field plugin.
- Import weight values from external sources via the bundled Feeds target.
- Combine a weight field with other sort criteria (weight first, then title as tiebreaker).
- Add the same weight field to multiple bundles to order a mixed listing.
- Default new entities to weight `0` (the middle of the range) until reordered.
- Export the weight field's storage/settings as configuration between environments.
- Replace ad-hoc "sticky"/"promoted" flags with an explicit, orderable weight.
