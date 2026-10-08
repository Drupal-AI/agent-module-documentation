<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: revision cleanup

Defined by `Drupal\revision_delete_tools\Drush\Commands\RemoveRevisionsCommands`
(`::queueRemoveRevisions()`), registered with PHP 8 Drush attributes. No `drush.services.yml`;
the command is discovered via `\Drush\Attributes`. Requires Drush 12+ (attribute-based commands).

## `rdt:remove-revisions`

| Part | Detail |
|---|---|
| Command | `rdt:remove-revisions` |
| Alias | none |
| Arg `entityType` | Optional. e.g. `node`, `media`, `taxonomy_term`. Omit = every revisionable entity type on the site. |
| Arg `bundle` | Optional. e.g. `page`. Only meaningful with `entityType`. |
| Arg `entityId` | Optional. A single entity id. Only meaningful with `entityType` (+ `bundle` for readability). |
| Option `--keep` | Number of most-recent revisions to retain. Default `3` (`RemoveRevisions::REVISIONS_TO_KEEP`). |

### Behavior / dispatch

The three positional args select which service method runs (most specific wins):

| Given | Method called | Effect |
|---|---|---|
| `entityId` set | `queueRevisionsByEntityId($entityType, $entityId, $keep)` | Queue that one entity. |
| `bundle` set (no id) | `queueRevisionsByBundle($entityType, $bundle, $keep)` | Queue every entity of that bundle that has more than `keep` revisions. |
| `entityType` only | `queueRevisionsByType($entityType, $keep)` | Loop all bundles of the type, queue qualifying entities. |
| nothing | loop `getRevisionableEntityTypes()` → `queueRevisionsByType()` each | Queue across every revisionable entity type. |

### Validation & prompts

- `--keep < 1` is rejected: error `"At least the default revision must be kept"` (return, nothing queued).
- If `entityType` is given but not in `RemoveRevisionsService::getRevisionableEntityTypes()`, error `"Entity type <type> is not revisionable."` and abort.
- Interactive **confirmation** prompt `"Are you sure you want to queue revisions for deletion?"` (default yes). Pass `-y` / `--no-interaction` to skip in scripts.
- `bundle` and `entityId` are **not** validated against the entity type; a wrong value simply queues nothing.

### Important: this command only *queues*

Success messages say "Queued …". Actual deletion happens later in the `remove_revisions`
queue worker on the next cron run. To drain it immediately:

```bash
drush queue:run remove_revisions
```

### Examples

```bash
drush rdt:remove-revisions                          # all revisionable types, keep 3
drush rdt:remove-revisions node                     # all node bundles, keep 3
drush rdt:remove-revisions node page --keep=5       # page nodes, keep 5
drush rdt:remove-revisions node page 123 --keep=3   # one node (id 123), keep 3
drush rdt:remove-revisions media image 123          # one media entity, keep 3
drush rdt:remove-revisions node -y                  # skip the confirm prompt
```

See [../api/services.md](../api/services.md) for what the queue worker does to each entity.
