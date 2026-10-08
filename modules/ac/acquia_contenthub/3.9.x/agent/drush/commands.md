# acquia_contenthub Drush commands

Namespace `acquia:contenthub*`. Defined in `src/Commands/*` (registered via `drush.services.yml`).
Publisher/subscriber-specific commands ship in those submodules. Run `drush <cmd> --help` for
options. Grouped by purpose:

## Connection & credentials
- `acquia:contenthub-connect-site` — register this site as a client.
- `acquia:contenthub-disconnect-site` — unregister / delete the client.
- `acquia:contenthub:client` / `:client-update` / `:client-delete` — manage the client.
- `acquia:contenthub-update-client-metadata` — refresh client CDF metadata.
- `acquia:contenthub-update-secret` / `acquia:contenthub-regenerate-secret` — rotate the shared webhook secret.
- `acquia:contenthub-settings` — show current settings/provider.
- `acquia:contenthub:remote-settings` / `acquia:contenthub-remote` — inspect remote service settings.
- `acquia:contenthub:api` — low-level authenticated API calls to the service.

## Webhooks & interests
- `acquia:contenthub-webhooks` / `-webhooks-list` — manage/list webhooks.
- `acquia:contenthub-webhook-interests-add` / `-delete` / `-list` — manage interest lists.
- `acquia:sync-interests` — sync interest list with tracked entities.

## Filters
- `acquia:contenthub-filters` / `-filter-details` — list/inspect syndication filters.
- `acquia:contenthub-filters:attach` / `:detach` — attach/detach a filter to this site's webhook.

## Queues & syndication
- `acquia:contenthub-export-queue-run` (publisher) — process the export queue.
- `acquia:contenthub-import-queue-run` (subscriber) — process the import queue.
- `acquia:contenthub-enqueue-by-filters` (subscriber) — enqueue matching entities.
- `acquia:contenthub-re-queue` — requeue publisher/subscriber items.
- `acquia:contenthub-list-queue-items` / `acquia:contenthub:queues:syndications` — inspect queues.
- `acquia:contenthub:enable-syndication` / `:disable-syndication` (subscriber).

## CDF / entities (local inspection & transfer)
- `acquia:contenthub-export-local-cdf` / `-import-local-cdf` / `-local` / `-remote` — dump/load CDF.
- `acquia:contenthub-cdf-diff` — diff local vs remote CDF.
- `acquia:contenthub-delete` — delete a remote entity.
- `acquia:contenthub:entity-scan:filter` / `:orphaned` — scan entities against filters / for orphans.

## Maintenance & audit
- `acquia:contenthub-purge` — purge ALL content from the service (destructive).
- `acquia:contenthub:purge:post-operations` — post-purge cleanup.
- `acquia:contenthub:reindex` — reindex origin entities on the service.
- `acquia:contenthub-audit-entity` / `-audit-publisher` / `-audit-subscriber` — tracking audits.
- `acquia:contenthub:reoriginate` (publisher) — reassign origin.
- `acquia:contenthub-publisher-upgrade` / `-subscriber-upgrade` — schema/data upgrades.
- `acquia:contenthub-restore` — restore operations.
- `acquia:contenthub-fix-config-entities-with-null-uuids` (site_health) — repair NULL config UUIDs.
- `acquia:contenthub-dashboard-allowed-origins` (dashboard) — manage allowed origins.
