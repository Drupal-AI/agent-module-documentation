<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How overrides alter the Solr query

The core mechanism is an event subscriber, not an API you call. `SolrQueryAlterEventSubscriber`
(service `search_overrides.query_alter`) subscribes to `SearchApiSolrEvents::PRE_QUERY`
(`Drupal\search_api_solr\Event\PreQueryEvent`) → method `preQuery()`.

Flow (`src/EventSubscriber/SolrQueryAlterEventSubscriber.php`):

1. If request query `?ignore_overrides` is non-empty → return early (results unmodified).
2. Read the Search API query keys (`$query->getKeys()`); return if empty.
3. Split/assemble keys per the parse-mode conjunction. If `match_entire_string` config is set and
   there are multiple `AND` terms, only the full phrase is matched; otherwise the full phrase is
   added alongside each term.
4. Entity-query the `search_override` storage for an override whose `query` field is `IN` the keys.
5. For each matched override, collect `getElevatedIds()` and `getExcludedIds()`, mapping each node id
   to a Solr document id with `search_overrides_make_solr_id($index, $id, $current_lang)`.
6. `$solarium_query->addParam('elevateIds', implode(',', …))` and `addParam('excludeIds', …)` — Solr's
   native elevate/exclude query params do the actual re-ranking/removal.

## The `search_override` entity

`Drupal\search_overrides\Entity\SearchOverride` (entity type id `search_override`, base table). Fields:

| Field | Meaning | Accessors |
|---|---|---|
| `query` | The exact search string this override applies to | `getQuery()` |
| `elnid` | Entity-reference list of nodes to **elevate** | `getElevated()`, `getElevatedIds()`, `getElevatedLabels()` |
| `exnid` | Entity-reference list of nodes to **exclude** | `getExcluded()`, `getExcludedIds()` |

Access is governed by `SearchOverrideAccessControlHandler` (the `add`/`edit`/`delete`/`administer
search overrides` permissions). Deleting the last referenced entity from an override deletes the
override (see `Controller\Manager::processRemoval`).

## Solr id building

`search_overrides_make_solr_id(Index $index, $id, $current_lang)` (in `search_overrides.module`)
builds the per-index, per-language Solr document id used in `elevateIds`/`excludeIds`, so overrides
are language-aware — elevate/exclude only affect the current interface language's documents.

## Notes for agents

- This only works with a **Solr** Search API backend (`search_api_solr`); it hooks a Solr-specific
  event and relies on Solr's `elevateIds`/`excludeIds`. It does nothing for the DB backend.
- To temporarily see un-overridden results (debugging), append `?ignore_overrides=1` to the search URL.
- Overrides key off the *exact* query string (subject to `match_entire_string`); there is no fuzzy match.
