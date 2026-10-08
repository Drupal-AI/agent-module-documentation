# Synonyms Views Filter (synonyms_views_filter) — agent index

A Views filter that matches entities by name **or synonym**, optionally rendered as a synonyms-aware
autocomplete/select exposed control. Depends on `synonyms` + core `views`. No config page, no permissions.

- **Add it to a View + its options** → [configure/views.md](configure/views.md)

Key facts:
- Views filter plugin id `synonyms_entity` (`FilterPluginBase`).
- `hook_views_data()` attaches a "Synonyms of <entity type>" filter to each content entity's base table
  (`real field` = entity id key, `entity_type` set).
- Options: `widget` (from `synonyms.behavior_service->getWidgetServices()` — autocomplete/select) and
  `target_bundles`. Resolves name/synonym → entity ids via the provider service.
- To use a widget control, enable the matching submodule (`synonyms_autocomplete` / `synonyms_select`).
