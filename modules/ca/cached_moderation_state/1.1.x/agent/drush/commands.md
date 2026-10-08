# Cached moderation state — Drush commands

Defined in `src/Commands/CachedModerationStateCommands.php` (classic `drush.command` service,
needs Drush ≥ 10).

| Command | Args / options | Does |
|---|---|---|
| `cached-moderation-state:list-moderated-bundles` | `--format` (default csv) | Lists moderated bundles as `ENTITY_TYPE_ID:BUNDLE` (e.g. `node:article`). |
| `cached-moderation-state:sync-fields` | — | Runs `FieldConfigHandler::sync()` to create/delete the field instances so they match the moderated bundles. Use only if the auto-sync got out of step. |
| `cached-moderation-state:update` | `<bundles>` (comma list of `ENTITY_TYPE_ID:BUNDLE`), `--batch-size` (20), `--only-uninitialized` | Back-fills the cached state for the given bundles via a batch. |
| `cached-moderation-state:update-all` | `--batch-size` (20), `--only-uninitialized` | Back-fills every moderated bundle (calls `update` with all bundles). |

```bash
drush cached-moderation-state:list-moderated-bundles
drush cached-moderation-state:update node:article,node:page --batch-size=50
drush cached-moderation-state:update-all --only-uninitialized
drush cached-moderation-state:sync-fields
```

Notes:
- `update` requires a non-empty bundle list (throws otherwise) and each entry must be
  `ENTITY_TYPE_ID:BUNDLE`.
- `--only-uninitialized` limits the run to entities whose cached field is still empty (queries
  `notExists('cached_moderation_state.updated')`) — handy for resuming.
- The batch updates non-default revisions too and suppresses new revision creation.
