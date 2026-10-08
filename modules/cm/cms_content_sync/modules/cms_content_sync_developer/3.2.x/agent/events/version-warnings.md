# Version-mismatch detection & admin warnings

Two event subscribers implement the whole "your Flow config is out of date" feature. They are
internal, but integrators should know that **saving field/bundle config on a synced entity type
can trigger these warnings**.

## `EventSubscriber\VersionComparison` (service `cms_content_sync_developer.config_subscriber`)

Args: `@config.factory`, `@entity_type.manager`. Subscribes to:

| Event | Method | Behavior |
|---|---|---|
| `ConfigEvents::SAVE` | `doComparisonOnCreate()` | On any config save (skipped under CLI SAPI), extracts the entity type + bundle from the changed config (`entity_type`/`target_entity_type_id`, `bundle`/`target_bundle`). For each syndication `Flow` handling that type/bundle it compares the Flow's stored `version` against `Flow::getEntityTypeVersion()`; mismatches are recorded. Also detects new bundles reached through reference-field handlers with `export_referenced_entities`. |
| `ConfigEvents::DELETE` | `doComparisonOnDelete()` | On config delete (skipped under CLI), if the old config named an `entity_type` + `bundle` still handled by a Flow, that Flow is flagged. |

Both call `setMismatchingFlows()`, which merges the new mismatches into
`cms_content_sync.developer:version_mismatch` (deduplicated). Version data comes from the parent
module's `Flow` entity — this submodule only records the result.

## `EventSubscriber\VersionWarning` (service `cms_content_sync_developer.event_subscriber`)

Args: `@config.factory`, `@current_user`, `@messenger`. Subscribes to `KernelEvents::REQUEST`
(`showVersionWarning()`):

- Only runs for users with the parent permission **`administer cms content sync`**.
- Reads `version_mismatch`; for each still-existing per-bundle Flow it builds a link to the Flow
  edit form (`entity.cms_content_sync_flow.edit_form`) and adds a warning: *"You have to update the
  related flow(s) … to keep the content synchronization intact."*
- Separately, for `simple`-variant Flows where `getController()->needsEntityTypeUpdate()` is true, it
  adds a second warning telling the admin to **export** those Flows.

The message is cleared for a Flow once it is re-exported via `drush csuf`
(see [../drush/commands.md](../drush/commands.md)).
