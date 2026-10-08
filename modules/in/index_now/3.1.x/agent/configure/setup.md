# index_now — configuration

Form **`index_now.settings`** at `/admin/config/services/index_now`
(*Config → Web services → Index Now*), permission `configure index now`. Config object
**`index_now.settings`**.

## Config keys (`index_now.settings`)

| Key | Type | Default | Purpose |
|---|---|---|---|
| `api_key` | string | generated UUID (ships as `whatever`, regenerated on install) | Domain-ownership key; also the key-file name/contents. |
| `default_engine` | string | `bing` (code default) | Endpoint to submit to. One of the `ENDPOINTS` keys below. |
| `verbose_mode` | bool | false | Also log **successful** submissions (warnings/errors always logged). |
| `cli_mode` | bool | false | Allow pings from CLI context (Drush, queue workers). When off, CLI saves never ping. |
| `async_mode` | bool | false | Queue submissions (`index_now_submissions`) and send on cron instead of inline. |
| `exclude_node_types` | sequence | — | Node bundles excluded from pinging. |
| `exclude_node_events` | sequence | — | Node events (`insert`/`update`/`delete`) excluded. |
| `exclude_vocabularies` | sequence | — | Taxonomy bundles excluded. |
| `exclude_taxonomy_events` | sequence | — | Taxonomy events excluded. |

The submodule/other plugins add their own `exclude_*` keys (e.g.
`exclude_commerce_product_types`). The form builds one **vertical tab per registered EntityIndexer
plugin** using the plugin's `bundleConfigKey` / `eventConfigKey`, so excludes are generated
dynamically — there's no hardcoded product/store section anymore.

Search-engine endpoints (`IndexNowInterface::ENDPOINTS`): `amazon`, `bing`, `indexnow`, `naver`,
`seznam`, `yandex`, `yep`. Per the protocol, submitting to one shares with all participating
engines.

## The API key

- Generated on install (`hook_install` → `IndexNowKeyManager::generateKey()`, a `uuid->generate()`),
  stored at `index_now.settings:api_key`. `hook_requirements` warns (runtime) if empty.
- Served to search engines as **plaintext** at `/index_now_api_key_{key}.txt`: an inbound path
  processor (`IndexNowPathProcessor`) rewrites that path to `/index_now_api_key/{key}`, handled by
  `ApiKeyController`, which returns the key **only if it matches** the stored key (else 404). The
  route `index_now.api_key` is intentionally `_access: 'TRUE'` (anonymous) because engines must
  fetch it.
- The `keyLocation` sent to the engine defaults to `base:index_now_api_key_{key}.txt`, or uses
  `Settings::get('index_now.base_url')` if set (headless/decoupled).
- Regenerate anytime: **Generate the API key** button on the form (shown when empty), or
  `drush index_now:keygenerate`.

## What actually gets submitted

`AbstractEntityOperations` builds the entity's absolute canonical URL in its own language and calls
the `index_now.indexnow` service. Indexability rules (`isEntityIndexable()`): skip if CLI and
`cli_mode` off; on **insert**, skip if anonymous can't `view` the entity; skip if the event is in
the type's excluded-events; skip if the bundle is in the type's excluded-types. Path-alias
insert/update also trigger a ping for the aliased entity.

## Setup checklist

1. Enable the module (key auto-generates). If the requirements warning shows, run
   `drush index_now:keygenerate`.
2. Pick `default_engine`; set any bundle/event excludes per type.
3. For high-traffic sites enable `async_mode` and ensure cron runs.
4. Enable `cli_mode` only if you want Drush/queue content changes to ping.
