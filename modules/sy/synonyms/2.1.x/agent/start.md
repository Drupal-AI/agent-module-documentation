# Synonyms (synonyms) — agent index

Framework that gives any content entity "synonyms" (alternate labels read from fields). Core module
defines the **`synonyms_provider`** plugin type, two shipped providers (`field`, `base-field`), a
**Synonym** config entity (`synonym.*`), a **behavior** service tag (`synonyms_behavior`), and the
`synonyms.provider_service` runtime API. No effect on its own — the seven submodules are the actual
integrations. `configure` → `synonyms.overview` (`/admin/structure/synonyms`). Core-only deps.
Permission: `administer synonyms`.

- **Admin UI: configure providers per entity type/bundle, the settings/behavior forms, permissions** →
  [configure/synonyms.md](configure/synonyms.md)
- **Implement a custom `synonyms_provider` plugin (Get/Find, annotation, derivers, field-type map)** →
  [plugins/provider.md](plugins/provider.md)
- **Runtime API: `synonyms.provider_service` & `synonyms.behavior_service` methods to call in code** →
  [api/services.md](api/services.md)
- **Hooks you can implement (`hook_synonyms_field_type_to_synonym_alter`, `synonyms_provider_info`)** →
  [hooks/hooks.md](hooks/hooks.md)

Submodules (own docs):
- `synonyms_autocomplete` → [../../modules/synonyms_autocomplete/2.1.x/agent/start.md](../../modules/synonyms_autocomplete/2.1.x/agent/start.md)
- `synonyms_list_field` → [../../modules/synonyms_list_field/2.1.x/agent/start.md](../../modules/synonyms_list_field/2.1.x/agent/start.md)
- `synonyms_search` → [../../modules/synonyms_search/2.1.x/agent/start.md](../../modules/synonyms_search/2.1.x/agent/start.md)
- `synonyms_select` → [../../modules/synonyms_select/2.1.x/agent/start.md](../../modules/synonyms_select/2.1.x/agent/start.md)
- `synonyms_views_argument_validator` → [../../modules/synonyms_views_argument_validator/2.1.x/agent/start.md](../../modules/synonyms_views_argument_validator/2.1.x/agent/start.md)
- `synonyms_views_field` → [../../modules/synonyms_views_field/2.1.x/agent/start.md](../../modules/synonyms_views_field/2.1.x/agent/start.md)
- `synonyms_views_filter` → [../../modules/synonyms_views_filter/2.1.x/agent/start.md](../../modules/synonyms_views_filter/2.1.x/agent/start.md)

Key facts:
- Plugin type `synonyms_provider`: manager `plugin.manager.synonyms_provider`, dir `Plugin/Synonyms/Provider`,
  annotation `@Provider`, interface `ProviderInterface`, alter hook `synonyms_provider_info`.
- Config entities: `synonym.*` (provider instance per entity-type/bundle/field) and `synonyms.settings`
  (global `wording_type`). Behaviors store `synonyms_<behavior>.behavior.<entity_type>.<bundle>` configs.
- Supported source field types (map in `FieldTypeToSynonyms`): text, entity_reference, integer/number,
  float, decimal, email, telephone.
