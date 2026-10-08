Entity Reference Extensions adds three drop-in field formatters for multi-value entity-reference fields that let you limit, offset, reverse, and sort the referenced items at display time, and (for the rendered variant) show the first N items in a different view mode.

---

The module provides three formatters that subclass core's entity-reference formatters and mix in `EntityReferenceDeltaFilterTrait`: `entity_reference_entity_view_delta` ("Rendered entity (PLUS)"), `entity_reference_entity_id_delta` ("Entity ID (PLUS)"), and `entity_reference_label_delta` ("Label (PLUS)"). Each adds a "Limit Configuration" (number of items to show, offset, reverse, and whether to limit before or after sorting), a "Sorting Configuration" (sort by a field/property on the referenced entities, ascending/descending; ties break by delta, missing values sort last), and — on the rendered variant only — a "Different Display" option to render the first N referenced entities in an alternate view mode. Sorting is done in PHP via `uasort()` over the loaded entities in `getEntitiesToView()`; limiting uses `array_slice`. The formatters only apply to fields whose cardinality is not 1 (`isApplicable()`). For unlimited-cardinality fields the settings-form "items to show/offset" select options are capped by a single global config value `entityreference_extensions.settings:unlimitedcounter` (default 10); there is no admin UI shipped to change it (`configure` is null) — set it via config. Configure a formatter on an entity's *Manage display* tab. Provides config schema for the three formatter setting shapes; no permissions, services, or Drush.

---

- Show only the first 3 referenced entities of a many-valued reference field.
- Show the last 3 referenced items by enabling "reverse" limiting.
- Skip the first N referenced items with an offset.
- Sort referenced nodes by a field on them (e.g. a date or weight) rather than field order.
- Sort referenced terms/users descending by a chosen property.
- Sort everything, then display the top 3 (limit after sorting).
- Take the first 3 items, then sort just those (limit before sorting).
- Ignore the last 3 items but sort the rest (offset + reverse + limit-before-sort).
- Display only the entity IDs of a limited/sorted subset (ID PLUS formatter).
- Display only the labels of a limited/sorted subset (Label PLUS formatter).
- Render referenced entities and show the first one in a "featured" view mode, the rest in default.
- Show the first 2 referenced entities as full teasers and the remainder compactly.
- Build a "top items" widget from a large reference field without a View.
- Cap how many options the limit/offset selects offer for unlimited-cardinality fields (`unlimitedcounter`).
- Present a curated ordering of referenced content on a display without changing stored order.
- Keep ties deterministic (broken by delta) when sorting referenced entities.
- Put entities that lack the sort field at the end of the list automatically.
- Apply different limits per view mode / form display of the same field.
- Provide an editor-order-independent display order for reference fields.
- Reduce render cost by only rendering a subset of a large reference field.
