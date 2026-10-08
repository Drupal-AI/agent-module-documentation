Synonyms List Field adds a computed, read-only "Synonyms list" base field to every content entity, exposing all of an entity's known synonyms as a display-configurable field.

---

The submodule implements `hook_entity_base_field_info()` (as `synonyms_entity_base_field_info()`) to add
a `synonyms` base field to every `ContentEntityTypeInterface`. The field is a `string`, computed,
read-only, unlimited-cardinality, and `setDisplayConfigurable('view', TRUE)`, backed by the item-list
class `SynonymsFieldItemList` which pulls values from `synonyms.provider_service`. Because it is computed
it stores nothing; it simply renders whatever the configured synonym providers return for that entity.
A single global setting, `include_entity_label` (config `synonyms_list_field.settings`, default FALSE),
controls whether the entity's own label is included in the list. You show the field by enabling it on the
bundle's *Manage display* tab. The companion `synonyms_views_field` submodule exposes the same `synonyms`
field to Views.

---

- Display all synonyms of a taxonomy term on the term page.
- Show a node's alternate labels in a chosen view mode.
- Give themers a `synonyms` field to place via Manage display.
- Optionally prepend the entity's own label to the synonyms list.
- Surface synonyms without writing a custom formatter or preprocess.
- Provide a read-only list that always reflects current provider config.
- Expose synonyms on user profiles (or any content entity).
- Feed the synonyms list into Views via synonyms_views_field.
- Present acronyms/aliases alongside the canonical name in the UI.
- Keep the display in sync automatically (computed, no stored data to reindex).
- Configure once globally whether the label is part of the list.
- Add a glossary-style "also known as" line to entity displays.
- Reuse the `SynonymsFieldItemList` values in custom render code.
- Show synonyms only where a provider is configured (empty otherwise).
- Offer editors a quick visual confirmation of an entity's configured synonyms.
