# Processing the regeneration queues

The module defines **no custom drush commands**. All work happens in two core queues that normally
drain on cron (each worker declares `cron = {"time": 30}`). To run them immediately, use core
Drush's `queue:run`:

```bash
# Collect/refresh alias→dependency records (also the queue filled at install time).
drush queue:run pathauto_update_path_alias_dependency_updater

# Regenerate the aliases whose dependencies changed.
drush queue:run pathauto_update_path_alias_updater
```

| Queue ID | Worker | Item payload | Effect |
|---|---|---|---|
| `pathauto_update_path_alias_dependency_updater` | `PathAliasDependencyUpdater` | `{id, type, language}` | Resolve the entity's token dependencies and store `path_alias_dependency` rows. |
| `pathauto_update_path_alias_updater` | `PathAliasUpdater` | `{id, type, language}` | `pathauto.generator->updateEntityAlias($entity, 'update')` + invalidate the entity's cache tags. |

Notes:
- Regeneration is asynchronous: a dependency change enqueues an item; the alias only changes once
  the `pathauto_update_path_alias_updater` queue is processed. Ensure cron runs, or drain manually
  as above (the `queue_run_all` / "Drush Queue Run All" approach also works).
- `hook_install` pre-fills the dependency queue with all existing `taxonomy_term`, `node`, `media`
  and Pathauto-enabled entities, so run the dependency queue once after enabling the module.
- This module changes the alias in place; it does not preserve the old alias. If old URLs matter,
  enable Pathauto's own "Create a new alias. Redirect from old alias." update action.
