# Synonyms Views Argument Validator (synonyms_views_argument_validator) — agent index

A Views contextual-filter (argument) validator that accepts an entity name **or a synonym** and
resolves it to the entity ID. Depends on `synonyms` + core `views`. No config page, no permissions.

- **Add it to a contextual filter + its one option** → [configure/views.md](configure/views.md)

Key facts:
- Argument-validator plugin id `synonyms_entity` (deriver per entity type; extends core `Entity`).
- `validateArgument()`: exact label match first (access-checked query; `user`→`name` column), else
  synonym lookup via `synonyms.provider_service->findSynonyms()`; on success sets
  `$this->argument->argument` to the entity id.
- Option `transform` (bool, default FALSE) — "Transform dashes in URL to spaces" before matching.
  Inherits core Entity validator bundle/access options.
