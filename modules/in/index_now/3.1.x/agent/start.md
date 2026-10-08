# index_now — agent start

Implements the **IndexNow** protocol: on entity insert/update/delete it submits the entity's
absolute canonical URL to a search-engine endpoint (Bing, Yandex, …). Which entity types are
covered is a **plugin type** (`#[IndexableEntity]` classes in `Plugin/EntityIndexer/`) — nodes and
taxonomy terms out of the box; products/stores via the `index_now_commerce` submodule. Domain
ownership is proven with a UUID **API key** served publicly at `/index_now_api_key_{key}.txt`.
Requires `path_alias` + `config_split`.

## Capabilities

- [Configure (settings form, engines, excludes, async, key generation)](configure/setup.md) — the
  `index_now.settings` keys, engine choice, per-type bundle/event excludes, async/verbose/cli
  modes, and how the key is generated & served.
- [EntityIndexer plugin type — register a new indexable entity](plugins/entity-indexer.md) — the
  `#[IndexableEntity]` attribute, `AbstractEntityOperations`, the manager, and the indexability
  rules.
- [Alter hooks](hooks/hooks.md) — `hook_index_now_url_alter()` and
  `hook_index_now_key_location_url_alter()`.
- [Programmatic pings — the IndexNow service](api/service.md) — `index_now.indexnow`
  `sendRequest()` / `doSendRequest()`, dedup, async queue.
- [Drush](drush/drush.md) — `index_now:keygenerate`.
- [Permissions](permissions/permissions.md) — `configure index now`, `view index now submission
  results`.
