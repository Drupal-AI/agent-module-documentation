# Taxonomy Term Delete Protection — agent index

Blocks deletion of taxonomy terms that are referenced by content (and protects parents whose descendants
are referenced). Configured **per vocabulary** on the vocabulary edit form — no dedicated settings page
(`configure` null), no permissions, no Drush. Depends on core `taxonomy`, `node`, `field`; auto-supports
Commerce products and Paragraphs when present. Provides a config schema.

- **Per-vocabulary config, the config object, and the four protection layers** →
  [configure/protection.md](configure/protection.md)
- **The `TermReferenceChecker` service (reusable programmatic reference checks)** →
  [api/reference-checker.md](api/reference-checker.md)

Key facts:
- Config `term_delete_protection.settings`: `vocabularies[] = {vocabulary_id, protected_entity_types[]}`.
  Set via `hook_form_taxonomy_vocabulary_form_alter` + custom submit.
- Protection layers: REQUEST event subscriber blocks the delete-form route
  (`src/EventSubscriber/TermDeleteProtectionSubscriber.php`); `hook_entity_operation_alter` removes the
  Delete link; `hook_form_taxonomy_term_form_alter` removes the delete button + warns; term-overview alter
  highlights protected rows.
- Reference logic in service `term_delete_protection.reference_checker`
  (`src/Service/TermReferenceChecker.php`): dynamic taxonomy-reference field discovery, recursive descendant
  checks, paragraph→parent resolution. Entity queries use `accessCheck(TRUE)`.
