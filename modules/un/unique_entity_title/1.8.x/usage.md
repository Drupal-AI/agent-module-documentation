Unique Entity Title enforces that the title of a node (or the name of a taxonomy term) is unique within its bundle, rejecting duplicates at validation time.

---

The module adds an opt-in setting on each content type and taxonomy vocabulary that, when enabled, requires every entity title/name in that bundle to be distinct. It works by attaching a `UniqueEntityTitle` validation constraint to the `title` base field of nodes and the `name` field of taxonomy terms via `hook_entity_base_field_info_alter()` and `hook_entity_bundle_field_info_alter()`. The constraint validator runs only when the bundle has the setting enabled (stored as a `third_party_settings` flag keyed on `unique_entity_title`), so unmarked bundles are unaffected. Uniqueness is checked with an entity query scoped to the same bundle, trimming whitespace and excluding the current entity so edits to an existing entity do not collide with themselves. Because it is a field constraint, the check fires wherever entity validation runs: the node/term edit forms, the entity API, JSON:API, and REST. Configuration is per bundle only — there is no central settings form, no permissions, and no Drush commands. An update hook (`unique_entity_title_update_8001`) migrates legacy taxonomy settings from the old `unique_entity_title.settings` config keys into per-vocabulary third-party settings. Only node and taxonomy_term entity types are supported.

---

- Prevent two nodes of the same content type from sharing an identical title.
- Ensure article headlines are unique across the Article content type.
- Stop editors from creating duplicate landing pages with the same title.
- Enforce unique product names within a "Product" content type.
- Require unique term names inside a specific taxonomy vocabulary (e.g. Tags).
- Keep a "Categories" vocabulary free of duplicate category names.
- Catch accidental duplicate content submissions before they are saved.
- Block duplicate titles submitted through JSON:API entity POST requests.
- Block duplicate titles submitted through the REST entity resource.
- Validate uniqueness when entities are created programmatically via the entity API.
- Turn uniqueness on for some content types while leaving others unrestricted.
- Turn uniqueness on for some vocabularies while leaving others unrestricted.
- Provide a clear "already in use, must be unique" error to editors on the edit form.
- De-duplicate imported content by validating titles on save.
- Maintain a canonical list of unique event names within an "Event" content type.
- Ensure SKU-like or code-style titles remain unique per bundle.
- Allow the same title to exist across different bundles while forbidding it within one bundle.
- Respect a renamed Title field label (e.g. "Headline") in the uniqueness error message.
- Let editors safely re-save an existing node without tripping a false duplicate error.
- Ignore empty titles so the constraint does not conflict with required-field handling.
- Trim leading/trailing whitespace so "Foo " and "Foo" are treated as duplicates.
- Migrate legacy per-vocabulary uniqueness config forward via the module's update hook.
- Enforce data-quality rules on glossary or dictionary vocabularies.
- Prevent duplicate tag names that would fragment faceted search results.
- Keep menu/navigation source terms unique to avoid ambiguous references.
