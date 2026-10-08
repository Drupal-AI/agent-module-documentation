# WSE code API — services, revert events, per-workspace flags, route access check

All services use short-hand definitions with `autowire: true`; inject them by class name
(they are container-private, so type-hint the class in your own autowired service — you cannot
`\Drupal::service('...')` them by a string id).

## `Drupal\wse\WorkspaceReverter`

Reverts a **closed** (already-published) workspace back to the state before it was published.

```php
public function revert(\Drupal\workspaces\WorkspaceInterface $workspace): void
```

Behaviour: loads the "revert to" and "revert from" revision sets from
`PublishedRevisionStorage`, dispatches `WORKSPACE_PRE_REVERT`, restores the prior default
revisions outside any workspace, re-associates the previously-published revisions back to the
workspace, deletes the workspace's published-revisions record, sets `status` back to `open`,
then dispatches `WORKSPACE_POST_REVERT`. All inside one DB transaction. Also reached via the
UI form `Drupal\wse\Form\WorkspaceRevertForm` at
`/admin/config/workflow/workspaces/manage/{workspace}/revert` (permission `administer
workspaces`, requires `_workspace_status: closed`).

## `Drupal\wse\PublishedRevisionStorage`

Reads/writes the `workspace_published_revisions` table (const `TABLE`). Public methods:

| Method | Purpose |
|---|---|
| `storePublishedRevisions(WorkspaceInterface $workspace)` | Record the revisions about to be published + the revisions to revert to. |
| `storeAllRevisions(WorkspaceInterface $workspace)` | Snapshot all default revisions after a publish (used when `save_published_revisions = all`). |
| `getPublishedRevisions($workspace_id, $offset = NULL, $limit = NULL): array` | Revisions published by that workspace, `[entity_type_id => [revision_id => entity_id]]`. |
| `getRevertRevisions($workspace_id): array` | The revisions to revert to. |
| `getWorkspaceIdsPublishedBefore(int $timestamp, ?string $workspace_id = NULL): array` | Publish records older than a timestamp. |
| `getLastPublishedWorkspaceId()` | ID of the most recently published workspace. |
| `deleteRecord($workspace_id)` | Delete a workspace's publish record. |

## Revert events — `Drupal\wse\Event\WorkspaceEvents`

| Constant | Event name | When |
|---|---|---|
| `WORKSPACE_PRE_REVERT` | `wse.workspace.pre_revert` | before `WorkspaceReverter::revert()` restores revisions |
| `WORKSPACE_POST_REVERT` | `wse.workspace.post_revert` | after a successful revert |

Both carry `Drupal\wse\Event\WorkspaceRevertEvent` with `getWorkspace()`,
`getRevertToRevisions()`, `getRevertFromRevisions()` (each revision array keyed by entity type
ID → `revision_id => entity_id`). Subscribe like any Drupal event subscriber.

## Per-workspace publish flags (dynamic properties)

Set these on a `Workspace` object before it publishes to override config for that one publish:

- `$workspace->_save_published_revisions` — `'published'` | `'all'` | falsy (see config key).
- `$workspace->_clone_on_publish` — bool, override `clone_on_publish`.

The core publish form + WSE's `WseFormHooks::workspacePublishFormValidate()` set these from the
publish form; `WorkspacePublishingEventSubscriber` reads them.

## Route access check `_workspace_status`

`Drupal\wse\Access\WorkspaceStatusAccess` (tagged `access_check`, `applies_to: _workspace_status`).
Add `_workspace_status: open` or `_workspace_status: closed` to any route that has a
`{workspace}` parameter; access is allowed only when the workspace's `status` field matches.
WSE uses it to block `entity.workspace.activate_form` / `publish_form` on closed workspaces
and to gate the revert form to closed workspaces.

## Service decorators (informational)

- `WseWorkspaceManager` decorates `workspaces.manager`: returns no active workspace when a
  request carries `wse_bypass_workspace`, and refuses to treat a **closed** workspace as active.
- `WseWorkspacesLazyBuilders` / `WseNavigationWorkspacesLazyBuilder` decorate the switcher
  lazy-builders. `WseServiceProvider` decorates `diff.entity_parser` when the `diff` module is on.
