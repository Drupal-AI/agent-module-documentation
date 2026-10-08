Synonyms Select Widget provides a synonyms-friendly select (dropdown) widget for entity-reference fields, where each referenceable entity appears once per synonym (and by its label) so users can choose it by any known name.

---

The submodule registers a field widget `synonyms_select` for `entity_reference` fields plus a
`synonyms_entity_select` render element (extends core `Select`). It adds a `select` behavior service
(`synonyms.behavior.select`, tagged `synonyms_behavior`, also a `WidgetInterface`). When building
options, `SelectService::selectGetSynonymsMultiple()` asks each configured provider (for bundles whose
**select** behavior is enabled) for the synonyms of the referenceable entities and formats each with the
provider's wording; the select element encodes options as `"<entity_id>:<synonym>"` (delimiter `:`) so a
single entity can be listed several times — once per synonym — while all options resolve back to the same
target id on submit. Two settings are stored per widget: `default_wording` (option label wording, default
`@synonym is the @field_label of @entity_label`) and `sort_select` (sort the dropdown, default FALSE); a
global settings form (`synonyms_select.settings`) holds the same defaults. Depends on `synonyms`.

---

- Let editors pick a term from a dropdown by any of its synonyms.
- Show one option per synonym so alternate names are all selectable.
- Reference an entity by label or by an alias in a single select.
- Sort the dropdown options alphabetically (`sort_select`).
- Customize the option wording (`default_wording`).
- Add synonym-aware selection to any entity-reference field via Manage form display.
- Reuse the `synonyms_entity_select` element in a custom form.
- Enable the "select" behavior per entity type/bundle to opt bundles in.
- Provide a no-typing alternative to the autocomplete widget.
- Support single or multi-select entity reference by synonym.
- Present acronyms and full names as separate, equivalent choices.
- Keep the same stored target id regardless of which synonym was chosen.
- Offer a friendlier picker for controlled vocabularies with many aliases.
- Format options as "synonym is the field of entity" for clarity.
- Avoid duplicate stored values even when multiple synonyms match one entity.
