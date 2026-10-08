# Language Hierarchy — Views sort & filter

The module registers two Views handlers (instances of core Views base classes — it does **not**
define a new plugin type) on every entity data/revision table that has a `language` filter, via
`hook_views_data_alter()` in `language_hierarchy.views.inc`.

## Sort: "Content language relevance"
- Views id `language_hierarchy_sort` → class `LanguageHierarchySort`
  (`@ViewsSort("language_hierarchy_sort")`, extends `SortPluginBase`).
- Data key added per table: `language_hierarchy_sort` ("Content language relevance").
- Sorts rows by how relevant each row's language is to the **current content language** within the
  configured hierarchy (using the `language_hierarchy_priority` ordering). Use it to show the most
  specific translation first.

## Filter: "Most relevant translation (using fallback)"
- Views id `language_hierarchy_content_language_fallback_limited` → class
  `ContentLanguageFallbackLimitedFilter`
  (`@ViewsFilter("language_hierarchy_content_language_fallback_limited")`, extends
  `FilterPluginBase`).
- Data key added per table (only where the langcode column's filter is the core `language`
  filter): `language_hierarchy_content_language_fallback_limited_<langkey>`
  ("Most relevant translation (using fallback)").
- Keeps only **one row per base entity**: the single translation that is most specific to the
  current content language along the fallback chain. It works by setting
  `build_info['language_hierarchy_limit']` metadata that the module's
  `language_hierarchy_query_language_hierarchy_limit_alter()` (`hook_query_TAG_alter` on
  `language_hierarchy_limit`) turns into a correlated sub-query joined through the priority table
  (see [../api/mechanism.md](../api/mechanism.md)). Language-neutral (`und`) rows are not excluded.

## Using them
In a content View, add the **"Most relevant translation (using fallback)"** filter to collapse
each item to its best translation for the viewer's language, and/or add the **"Content language
relevance"** sort to order by specificity. Both rely on the languages having their
`fallback_langcode` hierarchy configured; with no hierarchy they degrade to weight-based ordering.
