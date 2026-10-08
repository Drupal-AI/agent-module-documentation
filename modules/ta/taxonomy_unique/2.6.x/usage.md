Taxonomy Unique adds a per-vocabulary "Terms should be unique" option that rejects saving a term whose name already exists in the same vocabulary (and language), with a configurable error message.

---

The module works by adding a validation constraint to the taxonomy term `name` base field. `hook_entity_base_field_info_alter()` attaches the `taxonomy_unique` constraint to `name` for the `taxonomy_term` entity type, so it runs on every term save through core's entity validation. The constraint's validator only fires when the term's vocabulary has the module's `enabled` third-party setting turned on; it then calls the `taxonomy_unique.manager` service's `isUnique()` method, which runs an entity query filtering by `vid`, `name` and `langcode` (tagged `taxonomy_unique`) to detect a same-named sibling, ignoring the term itself on edit. On a duplicate it adds a violation using the vocabulary's custom `message` third-party setting (with `%term` and `%vocabulary` placeholders) or the built-in default. Configuration is exposed as a "Taxonomy unique" fieldset on each vocabulary's edit form (an "unique" checkbox and an "unique_message" textfield), stored as third-party settings on the `taxonomy.vocabulary.*` config entity — there is no global settings page (`configure: null`). The module also ships a `taxonomy_unique` EntityReferenceSelection handler that prevents duplicate terms from being **auto-created** through an autocomplete reference field. It has no permissions and no Drush commands.

---

- Prevent editors from creating two "News" terms in a Tags vocabulary.
- Enforce a canonical list of category terms with no accidental duplicates.
- Keep a country/region vocabulary clean by blocking repeated names.
- Show a custom, branded error message when a duplicate term is entered.
- Allow the same term name to exist in *different* vocabularies while forbidding duplicates within one.
- Permit the same name in different languages (uniqueness is per `langcode`).
- Stop free-tagging autocomplete fields from silently auto-creating duplicate terms (via the unique selection handler).
- Maintain data integrity for taxonomy used as a controlled vocabulary.
- Deduplicate an import workflow by relying on save-time validation to reject repeats.
- Guard a "Brand" or "Manufacturer" vocabulary against typo-driven duplicates.
- Enable uniqueness on only the vocabularies that need it, per vocabulary.
- Provide translators a clear message (with %term/%vocabulary) when a term collides.
- Programmatically check term uniqueness before save using the `taxonomy_unique.manager` service.
- Use the constraint in custom validation flows on taxonomy terms.
- Keep tag clouds and faceted filters tidy by ensuring one term per concept.
- Prevent duplicate menu-like taxonomy entries used to build navigation.
- Enforce uniqueness on event-type or product-attribute vocabularies.
- Configure the behavior through exported config (third_party_settings on the vocabulary) for deployment.
- Turn uniqueness on/off per environment by overriding the vocabulary config.
- Ensure REST/JSON:API term creation also respects uniqueness (validation runs on entity save).
- Reduce editorial cleanup work by catching duplicates at entry time rather than later.
- Combine with an autocomplete "Tags" widget so both manual and auto-created terms stay unique.
