# Taxonomy Unique — agent index

Rejects saving a taxonomy term whose **name already exists in the same vocabulary and
language**. Enabled **per vocabulary** via third-party settings; enforced by a validation
constraint on the term `name` field. No configure route (`configure: null`), no settings
page, no permissions, no Drush. Depends on `taxonomy`.

- **Turn uniqueness on for a vocabulary, set the custom error message, where it's stored** →
  [configure/vocabulary.md](configure/vocabulary.md)
- **How enforcement works (constraint, validator, the `taxonomy_unique.manager` service) and the unique EntityReferenceSelection handler** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Per-vocabulary settings live on the config entity `taxonomy.vocabulary.<vid>` under
  `third_party_settings.taxonomy_unique.enabled` (bool) and `.message` (string).
- Uniqueness key = same `vid` + `name` + `langcode` (case-sensitive DB match); a term does
  not collide with itself on edit.
- Default message: `Term "%term" already exists in vocabulary "%vocabulary".`
- Service `taxonomy_unique.manager` → `isUnique(TermInterface $term): bool`.
- Also ships an EntityReferenceSelection plugin id `taxonomy_unique` that blocks
  **auto-creating** duplicate terms from an autocomplete reference field.
