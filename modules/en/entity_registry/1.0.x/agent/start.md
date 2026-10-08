# Entity Registry — agent index

Generic entity-tracking framework: auto-captures insert/update/delete on content entities (per
translation) and dispatches to **consumer plugins** you write. Handles status lifecycle, retries,
queue/cron, batch, and locking. Drupal 11, PHP 8.1+. All admin routes gated by
`administer entity registry` (`restrict access: true`). No config UI declared in info.yml
(`configure` null); dashboard is `entity_registry.admin` → `/admin/config/system/entity-registry`.

- **Write a consumer plugin (`#[EntityRegistryConsumer]`, the method contract, phases, filtering)** →
  [plugins/consumer.md](plugins/consumer.md)
- **Services (`entity_registry.tracker`, `.processor`, `.consumer_manager`), config keys, hooks, DB table** →
  [api/services.md](api/services.md)
- **Drush commands (status / process / queue / retry / clear / rebuild)** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Plugin type: attribute `#[EntityRegistryConsumer(id, label)]`, base
  `EntityRegistryConsumerBase`, dir `Plugin/EntityRegistryConsumer/`, manager
  `entity_registry.consumer_manager`.
- Tracking table `entity_registry`, PK (consumer_id, entity_type, entity_id, langcode);
  status 0=PROCESSED, 1=PENDING, 2=FAILED (`TrackerInterface` constants).
- Phases passed to `processItem()`: `save` (sync), `cron` (queue worker + `hook_cron`), `batch`.
- Global config `entity_registry.settings`: `cron_enabled` (true), `batch_size` (50),
  `chunk_size` (1000). Per-consumer override `entity_registry.consumer.<id>.batch_size`.
- All state-changing routes require the `restrict access: true` permission
  `administer entity registry`; Tracker uses the parameterized DB API (no dynamic table/SQL).
