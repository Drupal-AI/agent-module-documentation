Dynamic Entity Reference (DER) provides a field type whose single field can reference more than one entity type at once — for example a "related" field that can point at nodes, users, or taxonomy terms interchangeably.

---

Core's Entity Reference field locks each field to a single target entity type, so pointing at nodes *and* users requires two separate fields. DER removes that limitation with a `dynamic_entity_reference` field type that stores both a `target_id` and a `target_type` per value, letting one field reference any allowed content entity type. In the field storage settings you either whitelist or blacklist entity types (`exclude_entity_types` + `entity_type_ids`), and per-type selection handler settings control which bundles are referenceable, just like core's reference handlers. It ships default, options-select and options-buttons widgets and both label and rendered-entity formatters, plus a validation constraint that keeps values pointing at allowed types. DER extends core's entity-reference selection system through its own `dynamic_entity_reference_selection` plugin manager, integrates with Views (exposing the target type/id), and supports the Diff module for revision comparison. It works across content entities and is a common building block for flexible data models, paragraph-style relationships, and polymorphic "attach anything" fields. The field is queryable through the entity query and typed-data APIs using the `target_type`/`target_id`/`entity` properties. It requires only core's Field module and targets Drupal 10, 11 and 12.

---

- Create one "related content" field that can point at nodes or terms or users.
- Build a polymorphic "attachment" field that references any content entity.
- Reference both taxonomy terms and nodes from a single categorization field.
- Let editors link a piece of content to a user *or* another node.
- Whitelist exactly which entity types a field may reference.
- Blacklist a few entity types while allowing all the rest.
- Restrict referenceable bundles per entity type via selection handler settings.
- Replace two separate entity-reference fields with one dynamic field.
- Model many-to-many relationships that span heterogeneous entity types.
- Display referenced entities as plain labels with the label formatter.
- Render referenced entities in a view mode with the entity formatter.
- Offer editors a select-list widget across multiple entity types.
- Offer radio/checkbox buttons for choosing the referenced type and entity.
- Validate that submitted references only target allowed entity types.
- Expose the target type and id as columns/relationships in Views.
- Compare dynamic references across revisions with the Diff module.
- Set a reference programmatically with explicit `target_type` + `target_id`.
- Assign an entity object directly to a DER field in custom code.
- Query entities by the referenced target type in an entity query.
- Power a flexible "mention" or "tagging" system that spans entity types.
- Build paragraph/component data models that attach varied entity kinds.
- Migrate legacy multi-type reference data into a single unified field.
- Provide decoupled/JSON:API consumers a single field carrying mixed references.
- Reference config-like and content entities from one editorial widget.
- Keep a normalized reference table with a combined target_id/target_type index.
