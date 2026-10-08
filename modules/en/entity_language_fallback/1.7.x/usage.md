Entity Language Fallback lets administrators define, per language, a prioritised list of fallback languages that Drupal uses when an entity has no translation in the requested language, so a missing translation is shown in the next best language instead of the site default.

---

The module hooks `hook_language_fallback_candidates_alter()` for the `entity_view` and
`entity_upcast` operations and replaces core's fallback candidate list with a per-language
chain you configure. Configuration is added straight onto the **language edit form**
(`language_admin_edit_form`): for each language you set "Priority 1..N" fallback languages,
stored as a third-party setting `fallback_langcodes` on the `configurable_language` config
entity (schema `entity_language_fallback`). The `FallbackController` service
(`language_fallback.controller`) resolves the chain, computes entity fallback candidates, and
can return the best-matching existing translation of an entity (`getTranslation`) or the full
set of effective translations including fallbacks (`getTranslations`). Because a fallback
entity may not match the page's content language, the module implements
`hook_entity_access()` (via `AccessHelper`) to re-check access against the fallback entity so
core access handlers behave correctly. It also ships optional **Search API** integration — a
`ContentEntityFallback` datasource plus `hook_entity_insert/update/delete` and index-item
tracking — so fallback translations get indexed and can be searched. There is no permission or
settings route of its own; it depends only on core `language`.

---

- Show a French visitor the English version of a node that hasn't been translated to French.
- Define a "Norwegian → Danish → English" fallback chain for Scandinavian languages.
- Give each language its own prioritised list of substitute languages.
- Fall back through several languages in order until a translation exists.
- Keep entity pages rendering instead of 404/empty when a translation is missing.
- Apply fallback during route entity upcasting as well as entity view.
- Return the best available translation of an entity from custom code.
- Get the full effective translation set (real + fallback) for an entity programmatically.
- Ensure access checks run against the actually-rendered fallback translation.
- Index fallback translations in Search API so untranslated content is still findable.
- Track insert/update/delete of fallback translations in a Search API index.
- Provide consistent content coverage across a partially-translated multilingual site.
- Configure fallbacks directly from the standard language administration screens.
- Avoid always dropping straight to the site default language for missing translations.
- Support regional language variants that should borrow from a parent language.
- Let editors translate incrementally while visitors still see complete pages.
- Drive a Search API view/facet over content that includes fallback languages.
- Prioritise a lingua-franca (e.g. English) as the last-resort fallback everywhere.
- Reuse one master-language translation across many under-translated locales.
- Reduce "content not available in your language" gaps on multilingual sites.
