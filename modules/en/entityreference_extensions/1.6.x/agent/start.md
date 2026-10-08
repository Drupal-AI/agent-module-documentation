# Entity Reference Extensions — agent index

Three "PLUS" field formatters for multi-value entity-reference fields that limit / offset / reverse /
sort the items at display time, plus an optional "first N in a different view mode" for the rendered
variant. No permissions, no Drush, no admin UI page (`configure` null); one global config value.

- **The three formatters, every setting, sort/limit semantics, and how to set them** →
  [configure/formatters.md](configure/formatters.md)

Key facts:
- Formatter ids: `entity_reference_entity_view_delta` (Rendered entity PLUS),
  `entity_reference_entity_id_delta` (Entity ID PLUS), `entity_reference_label_delta` (Label PLUS).
- All subclass the matching core formatter and use `EntityReferenceDeltaFilterTrait`
  (`src/EntityReferenceDeltaFilterTrait.php`).
- Only applicable to fields with cardinality != 1.
- Sorting is PHP `uasort()` in `getEntitiesToView()`; limiting is `array_slice`. Ties → delta; missing
  sort value → end of list.
- Global `entityreference_extensions.settings:unlimitedcounter` (default 10) caps the limit/offset
  select options for unlimited-cardinality fields; no shipped form to edit it.
