# Migrating from Acquia Content Hub

No settings object — this submodule runs a migration that writes standard Content Sync config.
Two form routes drive it, both gated by the parent permission `administer cms content sync`.

## Forms / routes

| Route | Path | Form | Purpose |
|---|---|---|---|
| `cms_content_sync_migrate_acquia_content_hub.migrate_pushing` | `/admin/config/services/cms_content_sync/migrate-acquia-content-hub` | `Form\MigratePush` | Build a **pushing** Flow from the site's Acquia Content Hub entity/bundle configuration. |
| `cms_content_sync_migrate_acquia_content_hub.migrate_pulling` | `/admin/config/services/acquia-contenthub/contenthub_filter/migrate-content-hub-filter/{content_hub_filter_id}` | `Form\MigratePull` | Build a **pulling** Flow from a specific Content Hub filter. |

`hook_entity_operation_alter()` adds a **"Migrate to Content Sync"** operation to every
`ContentHubFilter` list row, linking to the pulling form for that filter.

## Form fields (`Form\MigrationBase::buildForm()`)

| Field | Type | Notes |
|---|---|---|
| `backend_url` | url (required) | The Sync Core URL for the generated Pool. |
| `authentication_type` | select (required) | `cookie` (Standard); `basic_auth` is offered only when the `basic_auth` module is enabled. |
| `node_push_behavior` | select (push form only) | `automatically` or `manually` (`PushIntent::PUSH_AUTOMATICALLY` / `PUSH_MANUALLY`). |

## What submitting creates

1. **Pool** — `MigrationBase::createPools(DEFAULT_POOL, backend_url, authentication_type)` calls the
   parent's `Pool::createPool('Content', 'content', …)`, creating pool machine name `content`.
2. **Flow** — `MigratePush::createFlow()` / `MigratePull::createFlow()` reads the allowed entity
   types/bundles from `acquia_contenthub.entity_manager` (`getAcquiaContentHubConfigrations()`), then
   builds a `simple`-variant Flow via `FlowControllerSimple::createFlow()`: nodes get the chosen push
   behavior, everything else is pushed as a dependency (`PushIntent::PUSH_AS_DEPENDENCY`). For pulling,
   the Content Hub filter's tags are resolved to taxonomy terms (`getTermsFromFilter()`).
3. **Status entities** — `CreateStatusEntities::prepare()` queues a Batch API operation to create the
   `EntityStatus` records for the already-known entities.
4. Redirects to the new Flow's edit form (`entity.cms_content_sync_flow.edit_form`) so you can review.

The output is ordinary Content Sync config — after migrating, manage the Pool/Flow through the
parent module ([`../../../../../3.2.x/agent/configure/flows-and-pools.md`](../../../../../3.2.x/agent/configure/flows-and-pools.md)).
To script the same thing headlessly, use the `mach` Drush command
([../drush/commands.md](../drush/commands.md)).
