# Synchronizing external entities into local content

The core feature. It mirrors the records of an `external_entity_type` into rows of a local **node**
bundle, keyed by two string fields the module adds to the target bundle: `xnttid` (the external id)
and `xntttype` (the external type machine name).

## The `xnttsync` config entity (a sync cron)

`Drupal\xnttmanager\Entity\XnttSync` (`src/Entity/XnttSync.php`) — one config entity **per external
entity type** (its id *is* the `xnttType` machine name, so you cannot have two crons for the same
type). Config keys:

| Key | Meaning |
|---|---|
| `xnttType` | External entity type machine name (also the entity id). |
| `label` | Auto-generated, e.g. `"<Type label> Synchronization Cron"`. |
| `contentTarget` | Target content type in the form `"<entity_type>/<bundle>"`, e.g. `node/article`. Empty ⇒ auto-create a new node bundle. |
| `syncAddMissing` | Create a local node when an external record has none. |
| `syncUpdateExisting` | Update the local node when its fields differ from the source. |
| `syncRemoveOrphans` | Delete local nodes whose `xnttid` is no longer present in the source. |
| `frequency` | Seconds between runs (see format below). |
| `weight` | Order among crons (higher sinks to bottom; cron runs high→low weight). |
| `lastRunTime`, `inUse` | Runtime only (not exported). `inUse` is a lock set while running. |

## Routes / forms

- `xnttmanager.sync` → `/admin/structure/external-entity-types/sync` — `SyncForm` (entity op
  `xnttsync.sync`). One page that lets you **Synchronize now**, **Get statistics**, or **Create/Update
  a cron**. Selecting a type AJAX-loads the existing cron if one exists.
- `entity.xnttsync.list` → `…/sync/list` — `SyncListBuilder` table of crons.
- `entity.xnttsync.add_form` / `edit_form` / `delete_form` — standard config-entity add/edit/delete
  (`SyncAddForm`, `SyncEditForm`, `SyncDeleteForm`). All require `administer external entity types`.

The shared form is `SyncFormBase` (`src/Form/SyncFormBase.php`): the type `<select>` is populated by
`xnttmanager_get_external_entity_type_list()` (only types whose required fields are all mapped),
target by `xnttmanager_get_content_entity_type_list()` (node bundles only, key `node/<bundle>`).

### Frequency format

Free-text field validated by `SyncFormBase::validateForm()` against `^\d+[dhms]?$` and converted to
seconds: `d`=days ×86400, `h`=hours ×3600, `m`=minutes ×60, `s`/no-unit = seconds. Must be strictly
positive. Stored as an int; redisplayed via `formatFrequency()` in the largest exact unit.

## What "Synchronize now" / a cron actually does

`SyncForm::submitForm()` (`src/Form/SyncForm.php`) prepares the target bundle **before** syncing:

1. If `contentTarget` is empty it targets `node` and generates a bundle name `node_<xnttType>` (with a
   numeric suffix if taken), then **creates a `NodeType`** labelled `"<Type> Synchronized Content"`.
2. Ensures the bundle has string fields `xntttype` and `xnttid` (creates `FieldStorageConfig` +
   `FieldConfig`, `max_length` 255), labelled *"External Entity Type"* / *"External Entity Identifier"*.
3. If *"Add missing fields"* is on (implicit for a new bundle), clones every non-base field of the
   external type onto the local bundle (`createDuplicate()`, cleared deps/id).

Then, per button:

- **Synchronize now** → `performSync()` runs Batch API op `xnttmanager_bulk_process` with `sync=TRUE`
  plus the three `sync_*` flags. See [../api/internals.md](../api/internals.md) for the loop.
- **Get statistics** → `performStats()` runs the same batch with `sync_stats=TRUE` (counts
  missing/different/orphan content, writes nothing).
- **Create / Update cron** → saves the `xnttsync` config entity (`SyncFormBase::save()`).

## Scheduled runs — `hook_cron`

`xnttmanager_cron()` (`xnttmanager.module`) loads all `xnttsync` entities (sorted by `weight` DESC)
and, for each whose `lastRunTime + frequency < time()`, calls `XnttSync::synchronize()` unless its
`inUse` lock is set (a stuck lock only logs a warning and skips — re-save the cron to clear it).

`XnttSync::synchronize()` (`src/Entity/XnttSync.php`) sets the `inUse` lock + `lastRunTime`, then
iterates the source via the external type's data aggregator (`$aggregator->query([], [], $i, 1)` one
at a time), loading the mapped id field, and for each record: creates a node (if `syncAddMissing`),
or updates it field-by-field skipping id/uuid/xnttid/nid/default_langcode (if `syncUpdateExisting`),
handling translations by langcode. Orphan cleanup (if `syncRemoveOrphans`) queries local nodes with
`accessCheck(FALSE)` whose `xnttid NOT IN` the seen ids (scoped to `type` = bundle and `xntttype` =
type) and deletes them. New nodes default `uid` to `1` when the source has none. All steps are
try/caught and logged to the `xnttmanager` channel.

> Note: `frequency` is a floor only — actual cadence is limited by the site's own cron frequency.
