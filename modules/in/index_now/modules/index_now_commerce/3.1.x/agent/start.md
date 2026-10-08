# index_now_commerce — agent start

Submodule of **index_now** that adds IndexNow coverage for Commerce **products** and **stores**.
It contributes two EntityIndexer plugins and nothing else — all config, keys, permissions, Drush,
async queue, and ping logic come from the parent module. Requires `commerce_product` +
`index_now`. Configure at the parent's form (*Config → Web services → Index Now*).

## Capabilities

- [The two indexer plugins (and where config lives)](plugins/index_now_commerce.md) —
  `CommerceProductIndexer`, `CommerceStoreIndexer`, their config keys, and the deprecated legacy
  code.

For the plugin type mechanics, ping pipeline, engines, and key handling see the parent module's
docs (`../../../3.1.x/agent/…`), especially `plugins/entity-indexer.md` and `configure/setup.md`.
