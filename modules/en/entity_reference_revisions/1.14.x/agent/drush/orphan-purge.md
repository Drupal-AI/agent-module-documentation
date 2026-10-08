# Orphan revision cleanup

Composite children (e.g. paragraphs) whose parent no longer references them become **orphan
revisions**. ERR provides four ways to remove them.

## Drush
```
drush err:purge <types>      # alias: errp
drush err:purge paragraph    # purge orphaned paragraphs
drush err:purge              # interactive: pick a composite entity type from a list
```
`<types>` is a comma-delimited list of entity type ids. Defined in
`src/Drush/Commands/EntityReferenceRevisionsCommands.php`; it runs a batch via the purger.

## Admin form
Route uses `OrphanedCompositeEntitiesDeleteForm` (`src/Form/`). Access is gated by the
permission **`delete orphan revisions`** ("Delete orphan revisions").

## Programmatic / queue
- Service `entity_reference_revisions.orphan_purger`
  (`EntityReferenceRevisionsOrphanPurger`) — `getCompositeEntityTypes()`, `setBatch($types)`.
- Queue worker `src/Plugin/QueueWorker/OrphanPurger.php` processes purge jobs on cron.

## Permission
| Permission | Gates |
|---|---|
| `delete orphan revisions` | Access to the orphan-deletion admin form. |
