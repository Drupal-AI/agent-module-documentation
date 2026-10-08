<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OAI-PMH Harvester events & storage

## HarvestPreMergeEvent
Dispatched by `DecoderService` (constructed with `@event_dispatcher`) before a decoded record is merged into the database. Subscribe to it to alter the decoded CSL data prior to storage.

```php
// your_module.services.yml: an EventSubscriberInterface tagged event_subscriber
public static function getSubscribedEvents() {
  return [\Drupal\oai_pmh_harvester\Event\HarvestPreMergeEvent::class => 'onPreMerge'];
}
```

## Storage: oai_pmh_harvester_bib_records
`HarvesterService::harvestOne(SimpleXMLElement $xml)`:
- Derives `id` = `(int) explode(':', header.identifier)[1]` (cast to int).
- If header `status == 'deleted'`, deletes the row by id and returns `[id, 'deleted']`.
- Otherwise strips MARC `datafield[@tag="505"]`, decodes via `DecoderService::decodeOne()`, and MERGEs fields: `oai_pmh_time`, `harvested_data` (raw XML), `decoded_time`, `decoded_data` (JSON CSL), `authors`, `title`.
- Wraps failures in `DatabaseException`.

All writes use `Connection::merge()` / `->delete()` with bound keys/values — no string-concatenated SQL. The `id` is integer-cast before use.

## Referencing harvested data
Rows are keyed by the provider record id, so fields/formatters can look records up by id from the cache table.
