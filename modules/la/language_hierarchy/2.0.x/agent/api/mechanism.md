# Language Hierarchy — how fallback resolves

The stored `fallback_langcode` per language (see [../configure/fallback.md](../configure/fallback.md))
is turned into real fallback behaviour across four subsystems. All of it hangs off one hook plus a
priority table.

## The core hook
`language_hierarchy_language_fallback_candidates_alter()` implements
`hook_language_fallback_candidates_alter()`. Given a `langcode`, it walks the
`fallback_langcode` chain (loading each `ConfigurableLanguage`, guarding against loops) and builds
the candidate list. Outside `locale_lookup` it prepends the attempted language and appends
`LanguageInterface::LANGCODE_NOT_SPECIFIED` (`und`). So
`\Drupal::languageManager()->getFallbackCandidates(['langcode' => 'de-at'])` →
`['de-at' => 'de-at', 'de' => 'de', 'en' => 'en', 'und' => 'und']` for a `de-at → de` chain.
`language_hierarchy_module_implements_alter()` makes it run after `path_alias`'s own alter.

## The priority table
`language_hierarchy_update_priorities()` rebuilds `language_hierarchy_priority`
(langcode → priority) on every `configurable_language` insert/update/delete
(`hook_ENTITY_TYPE_insert/update/delete`) and on config import
(`LanguageHierarchyConfigEventSubscriber` on `ConfigEvents::IMPORT`). Deeper children get higher
priority; parentless languages get negative, weight-based seeds. This table is joined into queries
to order fallbacks.

## The four fallback surfaces
1. **Configuration translation** — `LanguageHierarchyServiceProvider` swaps
   `language.config_factory_override` for `LanguageHierarchyConfigFactoryOverride` (extends core
   `LanguageConfigFactoryOverride`). Its `loadOverrides()` / `getOverride()` read the requested
   language's config override and, if a value is missing, walk the fallback chain reading parent
   languages' overrides. Saves/deletes go to the correct (specific) storage via
   `LanguageHierarchyConfigOverride`.
2. **Interface translation (locale)** — only when `locale` is enabled, the ServiceProvider
   registers `StringDatabaseStorageDecorator` decorating `locale.storage`. Its `dbStringSelect()`
   rewrites the translation query to `t.language IN (:langcode[])` over the fallback candidates and
   `ORDER BY language_hierarchy_priority.priority DESC`, so a string missing in the specific
   language uses the closest parent's translation. The `translated` meta-condition bypasses
   fallback (used when querying a single language explicitly).
3. **Path aliases** — `language_hierarchy_query_path_alias_language_fallback_alter()`
   (`hook_query_TAG_alter` for `path_alias_language_fallback`) joins the priority table and
   replaces the langcode ordering so aliases resolve by hierarchy.
4. **Link language fixing** — `hook_preprocess_node` / `hook_preprocess_taxonomy_term` /
   `hook_preprocess_image_formatter` / `hook_preprocess_responsive_image_formatter` call
   `language_hierarchy_fix_url_from_fallback()`, which, when a rendered translation is only a
   fallback of the current page language, rewrites the link to use the current page language
   (recording a `language_hierarchy_fallback` URL option to avoid re-processing).

## The Views limit query tag
`language_hierarchy_query_language_hierarchy_limit_alter()` (`hook_query_TAG_alter` for
`language_hierarchy_limit`) adds a correlated sub-query (joined via the priority table) that keeps
only the single most-relevant translation per base row. This is what the "Most relevant
translation" Views filter uses — see [../plugins/views.md](../plugins/views.md).

## No API to call
There is no service you configure or public API beyond the standard language manager. To change
behaviour you change each language's `fallback_langcode`; everything else recomputes automatically.
`language_hierarchy_get_ancestors()` is a useful helper for reading a language's chain.
