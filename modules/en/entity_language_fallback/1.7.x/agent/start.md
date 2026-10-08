# Entity Language Fallback — agent index

Per-language, prioritised fallback chains used when an entity lacks a translation in the
requested language, applied on `entity_view` and `entity_upcast`. Depends on core `language`.
No permission, no settings route (`configure` null); config lives as a third-party setting on
each `configurable_language` entity, edited on the language edit form.

- **Setting fallback languages per language, config/storage shape, the alter hook** →
  [configure/fallback.md](configure/fallback.md)
- **`FallbackController` service methods and the Search API datasource/tracking** →
  [api/fallback.md](api/fallback.md)

Key facts:
- Hook `entity_language_fallback_language_fallback_candidates_alter()` overrides candidates for
  `operation` `entity_view`/`entity_upcast` using `FallbackController::getEntityFallbackCandidates`.
- Storage: `configurable_language` third-party setting
  `entity_language_fallback.fallback_langcodes` (ordered array of langcodes); schema key
  `language.entity.*.third_party.entity_language_fallback`.
- Service `language_fallback.controller` = `FallbackController`.
- Optional Search API: datasource `entity_language_fallback:<entity_type>`
  (`ContentEntityFallback`) + entity insert/update/delete tracking; active only when
  `search_api` is enabled.
- Implements `hook_entity_access()` (`AccessHelper`) to re-check access on the fallback
  translation.
