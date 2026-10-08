Synonyms enriches any content entity (taxonomy terms, nodes, users, etc.) with the notion of synonyms — alternate labels read from ordinary fields — and lets those synonyms be used for autocomplete, select widgets, search indexing and Views filtering/argument validation.

---

The core module is a framework: it defines a **`synonyms_provider`** plugin type whose plugins know how to (a) *get* the synonyms of an entity and (b) *find* entities by a synonym. Out of the box it ships two derivative-based providers — `field` (attached fields) and `base-field` — that pull synonyms from a configurable field's value for a supported field type (text, entity reference, number, float, decimal, email, telephone; the map is alterable via `hook_synonyms_field_type_to_synonym_alter()`). You wire providers up as **Synonym config entities** (`synonym.*`) at *Structure → Synonyms configuration* (`/admin/structure/synonyms`, permission `administer synonyms`): pick an entity type + bundle, add a provider, choose the field. A second concept, **behaviors**, are tagged services (`synonyms_behavior`) contributed by the submodules (autocomplete, select, search, …); a per-entity-type/bundle *Manage behaviors* form (`administer site configuration`) turns each behavior on and stores a wording string. The central `synonyms.provider_service` exposes the runtime API — `getEntitySynonyms()`, `getBySynonym()`, `findSynonyms()`, `getSynonymConfigEntities()`, `serviceIsEnabled()` — building entity queries (always `accessCheck(TRUE)`) whose synonym/entity-id columns are resolved through `FindInterface` placeholders. The module itself has no user-facing effect until you enable submodules; the *Synonyms UI* pieces (config forms) can be uninstalled on production once synonyms are configured. Seven submodules ship in the project, each a distinct integration (see below).

---

- Give taxonomy terms alternate names (e.g. "USA", "United States", "US") that all resolve to one term.
- Let an autocomplete on an entity-reference field match by synonym, not just the primary label.
- Present a select widget whose options include each entity's synonyms as choices.
- Make core Search find a node by a synonym of an entity it references.
- Add a Views exposed filter that matches entities by name *or* synonym.
- Validate a Views contextual filter argument against an entity's name or a synonym.
- Show a computed "Synonyms list" field on an entity's display.
- Expose that synonyms list as a Views field.
- Look up an entity ID from a user-typed synonym in custom code via `getBySynonym()`.
- Fetch all synonyms of a given entity programmatically with `getEntitySynonyms()`.
- Pull synonyms from a plain text field on a content type.
- Pull synonyms from an entity-reference field (referenced entities' labels become synonyms).
- Use a number/email/telephone field as a synonyms source.
- Support product SKUs or alternate part numbers as synonyms of a catalog entity.
- Register a custom `synonyms_provider` plugin for a bespoke storage of synonyms.
- Extend the list of "simple" field types eligible for synonyms via the alter hook.
- Configure different synonym providers per entity type and per bundle.
- Set human-readable "wording" (e.g. "@synonym is the @field_label of @entity_label") per behavior.
- De-duplicate multiple synonyms that point at the same entity in suggestions.
- Uninstall the Synonyms UI/config forms on production while keeping synonyms working.
- Improve findability of content that users refer to by informal or regional names.
- Build a glossary/acronym-expansion lookup on top of taxonomy synonyms.
- Match misspelling-tolerant alternate spellings stored as synonyms.
- Drive a "search by any known alias" experience across multiple entity types.
