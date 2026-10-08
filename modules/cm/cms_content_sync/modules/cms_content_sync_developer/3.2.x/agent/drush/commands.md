# Drush commands

Defined in `src/Commands/CMSContentSyncDeveloperCommands.php` (registered via `drush.services.yml`,
service `cms_content_sync_developer.commands`), delegating to `Cli\CliService`
(`cms_content_sync_developer.cli`).

| Command | Alias | Arguments / options | Action |
|---|---|---|---|
| `cms_content_sync_developer:update-flows` | `csuf` | none | `CliService::configurationExport()` — loads **all** Flows (`Flow::getAllUnfiltered(FALSE)`) and, on each, calls `getController()->updateEntityTypeVersions()` then `resetVersionWarning()`. Re-syncs stored entity-type versions and clears the `version_mismatch` warnings. Run after changing a synced content type. |
| `cms_content_sync_developer:force-entity-deletion` | `csfed` | `<entity_type>` arg; `--bundle=` **or** `--entity_uuid=` (exactly one) | `CliService::forceEntityDeletion()` — sets `CliService::$forceEntityDeletion = TRUE` so deletion **skips syndication** (the entity is removed locally without being pushed as a delete), then deletes the target after a confirm prompt. |

## `force-entity-deletion` details

- Requires exactly one of `--bundle` or `--entity_uuid`; supplying both or neither errors out.
- `--entity_uuid="<uuid>"` loads via `entity.repository`'s `loadEntityByUuid()`, confirms, deletes that single entity.
- `--bundle="<bundle>"` loads all entities of that bundle (`loadByProperties([bundle_key => bundle])`,
  with `menu_link_content` using `menu_name` as the bundle key), confirms once, deletes them all.
- Each destructive path prompts for confirmation (`UserAbortException` on decline).

```bash
# Re-export/update every Flow and clear version warnings
drush csuf

# Force-delete one node by UUID (skips the sync delete)
drush csfed node --entity_uuid="06d1d5b8-5583-4929-9f7c-c85cfe59440b"

# Force-delete every node of a bundle
drush csfed node --bundle="basic_page"
```

These are maintenance/recovery tools — use `csfed` to clear a stuck entity that normal deletion
won't remove from Content Sync bookkeeping.
