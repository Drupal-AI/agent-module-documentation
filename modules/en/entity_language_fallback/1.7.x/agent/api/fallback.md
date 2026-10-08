# Fallback API & Search API integration

## Service `language_fallback.controller` — `FallbackController`

Constructed with `language_manager` + `entity_type.manager`. Per-request memoised.

| Method | Returns | Notes |
|---|---|---|
| `getFallbackChain($lang_code)` | `string[]` | configured fallback langcodes for a language (from the third-party setting), most-preferred first. |
| `getEntityFallbackCandidates(ContentEntityInterface $entity, $language_code)` | `string[]` | candidate langcodes for the entity: requested language + chain, de-duplicated; `[]` if the entity isn't translatable. Cached per entity-type:bundle for the request. Used by the alter hook. |
| `getTranslation($lang_code, ContentEntityInterface $entity)` | `ContentEntityInterface\|false` | the entity's best existing translation walking the chain for `$lang_code`, or `false`. |
| `getTranslations(ContentEntityInterface $entity)` | `ContentEntityInterface[]` | keyed by langcode: for every site language, the real translation if present else the fallback translation. Used by the Search API tracking hooks. |

```php
$fc = \Drupal::service('language_fallback.controller');
$node_fr = $fc->getTranslation('fr', $node);       // real fr, or first available fallback
$all = $fc->getTranslations($node);                // effective translation per language
```

## Search API integration (optional)

Only active when `search_api` is enabled.

- **Datasource** `entity_language_fallback:<entity_type>` — `ContentEntityFallback`
  (`src/Plugin/search_api/datasource/`), derived per content entity type; indexes fallback
  translations as items `<entity_id>:<langcode>`.
- **Tracking hooks** in `entity_language_fallback.module`:
  `hook_entity_insert/update/delete` compute the fallback language set for the entity
  (`getTranslations`) and call `trackItemsInserted/Updated/Deleted` on each index using this
  datasource. Honours `$entity->search_api_skip_tracking`.
- **`hook_search_api_index_items_alter()`** sets each item's language from the indexed object.
- **Processor** `FallbackLanguage` (`src/Plugin/search_api/processor/`) is also provided.

This lets a Search API index return untranslated content under a fallback language so it is
still searchable/facetable in that language.

## Access re-check

`hook_entity_access()` → `AccessHelper::checkAccess()` re-runs access on the fallback entity
when the current content language differs from the entity's own language, so core access
handlers (e.g. node) evaluate the translation that is actually rendered.
