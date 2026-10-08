<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Update Runner plugins

## Plugin type

`update_runner` — an **attribute-based** plugin type.

- Attribute: `src/Attribute/UpdateRunner.php` (`id`, `label`, `description`, `update_types`).
- Manager: `src/Plugin/UpdateRunnerManager.php` (service
  `plugin.manager.scheduled_updates.update_runner`, discovers `src/Plugin/UpdateRunner/`).
- Interface: `src/Plugin/UpdateRunnerInterface.php`; base class `src/Plugin/BaseUpdateRunner.php`.
- Orchestrator service: `UpdateRunnerUtils` (`scheduled_updates.update_runner`).

Each `scheduled_update_type` selects one runner in its `update_runner` config. A type's supported
families (`embedded`/`independent`) must intersect the runner's `update_types`.

## The three runners

| id | class | update_types | purpose |
|----|-------|--------------|---------|
| `default_embedded` | `EmbeddedUpdateRunner` | `embedded` | Updates referenced from an entity-reference field on the target's own form. |
| `default_independent` | `IndependentUpdateRunner` | `independent` | Updates created on their own form; editor picks targets by autocomplete. |
| `latest_revision` | `LatestRevisionUpdateRunner` (extends Embedded) | `embedded` | Runs against the **latest** revision of revisionable content (moderation / forward revisions). Errors if the target type is not revisionable. |

`EmbeddedUpdateRunner` also implements `EntityMonitorUpdateRunnerInterface`: on `hook_entity_update`
it deactivates updates left behind on superseded revisions and reactivates updates present on the
current revision (`onEntityUpdate`).

## Run lifecycle (`BaseUpdateRunner`)

1. `addUpdatesToQueue()` — `getAllUpdates()` finds ready updates; each is pushed to queue
   `scheduled_updates:<type_id>` and marked `STATUS_INQUEUE`.
   - Ready = `update_timestamp <= request time` AND `status IN (Un-run, Re-queued)` AND matching
     type (`addActiveUpdateConditions`).
   - Embedded runners locate targets by querying the target's entity-reference fields
     (`getEntityIdsReferencingReadyUpdates`, `getReferencingFieldIds`) **with
     `accessCheck(FALSE)`**.
2. `runUpdatesInQueue($time_end)` — claim items until the timeout; for each,
   `runUpdate()`:
   - `prepareEntityForUpdate()` → `transferFieldValues()` copies each `field_map` value onto the
     target, removes the update from the reference field (embedded), sets revision behavior.
   - `switchUser()` per the `update_user` setting (see below), then `$target->validate()`.
   - If entity-level violations → log and treat as invalid (per `invalid_update_behavior`).
     Otherwise **`$target->save()`**.
   - `switchUserBack()`.

The timeout comes from `scheduled_updates.settings:timeout` (default 15s).

## Runner settings (schema: `update_runner.plugin`)

Built in `BaseUpdateRunner::buildConfigurationForm()`:

- **`after_run`** — `DELETE` (default) or `ARCHIVE` the update after a successful run
  (`Enum/AfterRunBehavior`).
- **`invalid_update_behavior`** — `DELETE` / `REQUEUE` (leave in queue, mark Re-queued) / `ARCHIVE`
  (mark Un-successful) when the target fails validation (`Enum/InvalidUpdateBehavior`).
- **`create_revisions`** — `BUNDLE_DEFAULT` / `YES` / `NO` (only shown for revisionable targets;
  `Enum/RevisionBehavior`).
- **`update_user`** — which account the save runs as (`Enum/UpdateUser`):
  - `USER_UPDATE_RUNNER` — the user running the updates; **under cron this becomes user 1**.
  - `USER_UPDATE_OWNER` — the update's creator; **under cron this also becomes user 1**.
  - `USER_OWNER` — the owner of the target entity.
  - `USER_REVISION_OWNER` — the owner of the latest revision.
- `default_independent` adds a **`bundles`** checkbox set restricting which target bundles an
  independent update may address.

## Access note (behavioral)

The runner performs the write with `AccountSwitcher` but does **not** call `access('update')` on
the target or check per-field write access before `save()`. Target lookup queries use
`accessCheck(FALSE)`. `validate()` runs field constraints (and `filterByFieldAccess()` is used only
for logging), but does not enforce edit permission. Under cron the acting account is user 1, which
passes everything. See the access model in `permissions/`.
