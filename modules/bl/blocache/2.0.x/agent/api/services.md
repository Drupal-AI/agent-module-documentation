# Blocache services & render mechanism

## Services (`blocache.services.yml`)

| Service id | Class | Purpose |
|---|---|---|
| `blocache` | `Drupal\blocache\Blocache` | Facade. `getMetadataService()`, `getTokenService()` (NULL if token module absent), `cacheContexts()` (discovers all `cache_context.*` services + their params via reflection), `prepareContextsToStorage()` / `prepareContextsFromStorage()`. |
| `blocache.metadata` | `Drupal\blocache\BlocacheMetadata` | Reads/writes the block's `blocache` third-party settings. `setBlock()`, `getMetadata()` (returns overrides if overridden, else code defaults from `getCacheMaxAge/Contexts/Tags`), `setOverrides($maxAge,$contexts,$tags)`, `unsetOverrides()`, `isOverridden()`. Constants: `MODULE='blocache'`, `OVERRIDEN='overridden'`, `METADATA_MAX_AGE='max-age'`, `METADATA_CONTEXTS='contexts'`, `METADATA_TAGS='tags'`. |
| `blocache.token` | `Drupal\blocache\BlocacheToken` | Token replacement for cache tags (only used when the `token` module is installed). |

There is no plugin type and no Drush command.

## How the override is applied at render time

`blocache.module` `hook_entity_type_build()` sets the **block** entity's view builder to
`Drupal\blocache\BlocacheViewBuilder` (extends core `BlockViewBuilder`). In `viewMultiple()`, for each
block whose `blocache.overridden` third-party setting is TRUE:

1. Reads the overridden metadata via `blocache.metadata`.
2. If the token service is available, runs `blocache.token->replaceAll()` over the **tags**.
3. Merges into the build's `#cache`:
   - `#cache['max-age']` = overridden max-age (replaces).
   - `#cache['contexts']` = `Cache::mergeContexts(overridden, existing)`.
   - `#cache['tags']` = `Cache::mergeTags(overridden, existing)`.
4. If the overridden max-age is exactly `0`, calls
   `\Drupal::service('page_cache_kill_switch')->trigger()` so the whole page the block sits on is not
   served from the page cache.

Blocks without an override are rendered exactly as core would (the parent `BlockViewBuilder`).

## The block form UI (for reference)

`hook_form_FORM_ID_alter()` for `block_form` builds the **Cache Settings** section (guarded by
`administer block cache`): an *Override cacheability metadata* checkbox and three vertical-tab groups
(Max-Age number, a checkbox per discovered cache context with an optional `__arg` textfield, and an
AJAX add-more Tags list). On submit, `BlocacheFormHelper::entityBuilder()` (added to
`$form['#entity_builders']`) writes the values into the block's `blocache` third-party settings.
