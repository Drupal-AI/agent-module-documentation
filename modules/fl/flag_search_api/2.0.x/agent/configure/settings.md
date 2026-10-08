# Configure Flag Search API

Config object: `flag_search_api.settings` (no schema file shipped; no `config/install` defaults). Form:
`\Drupal\flag_search_api\Form\FlagSearchApiConfigForm` at `/admin/config/search/flag-search-api`
(route `flag_search_api.admin`, permission `administer search_api`).

## Setting

| Key | Type | Meaning |
|---|---|---|
| `reindex_on_flagging` | bool | When on, flagging/unflagging an entity immediately marks the affected item(s) for reindex in every Search API index that contains the flagged entity. |

```php
\Drupal::configFactory()->getEditable('flag_search_api.settings')
  ->set('reindex_on_flagging', TRUE)->save();
```

## How reindex-on-flag works

- `FlagSearchApiSubscriber` (event subscriber) listens to Flag's `flag.entity_flagged` and
  `flag.entity_unflagged` events and calls `FlagSearchApiReindexService::reindexItem()`.
- The service checks `reindex_on_flagging`; if on, it resolves the flagged entity, finds the indexes
  containing it (`ContentEntity::getIndexesForEntity`), builds `entity_id:langcode` item IDs for every
  translation, and calls `$index->trackItemsUpdated($datasource_id, $ids)`.
- The subscriber runs regardless, but the service no-ops when the setting is off — so the reindex cost
  is only paid when explicitly enabled.

## The actual field selection is on the index, not here

Which flags get indexed is chosen on each Search API index's processor settings (see
plugins/processors.md), not on this form. This form only toggles the freshness behavior.
