# Publisher export & queue

## How export works
Entity create/update/delete enqueues the entity to the `acquia_contenthub_publish_export`
queue. Processing (cron or Drush) resolves dependencies via `depcalc`, serializes to CDF, and
sends to the service. Publish status is stored in the publisher tracker.

## Exclude entity types / bundles
Form `\Drupal\acquia_contenthub_publisher\Form\ExcludeSettingsForm` at
`/admin/config/services/acquia-contenthub/exclude-settings` (route
`acquia_contenthub_publisher.exclude_settings`, requires Content Hub UI access). Select entity
types/bundles that must never enter the export queue. Stored in publisher config.

## Push a single entity on demand
Action link + controller route `acquia_contenthub_publisher.add_to_export_queue`:
`/admin/config/services/acquia-contenthub/{entity_type}/{entity_uuid}/export-queue/add`
(`_csrf_token: TRUE`) — adds one entity to the export queue immediately.

## Drush
- `acquia:contenthub-export-queue-run` — process the export queue now.
- `acquia:contenthub-audit-publisher` — reconcile tracker vs actual entities.
- `acquia:contenthub-audit-entity <uuid>` — inspect one entity's export state.
- `acquia:contenthub:reoriginate` — reassign the origin UUID on published content.
- `acquia:contenthub-publisher-upgrade` — upgrade tracking data between versions.
- `acquia:contenthub-re-queue` — requeue publisher items (base command).

## Programmatic
Use `acquia_contenthub_common_actions` to serialize/export (see the base module's
`agent/api/services.md`). Requeue via the `acquia_contenthub_publisher.requeuer` /
`acquia_contenthub_publisher.export_queue_inspector` services.
