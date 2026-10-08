<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `taxonomy_term_revision.permissions.yml`. None are marked `restrict access`, so grant
them deliberately.

| Permission | Title | Where enforced |
|---|---|---|
| `view term revision list` | View list of taxonomy term revisions | Route requirement of `taxonomy_term_revision.all` (the Revisions tab / list page). |
| `revert term revision` | Revert taxonomy term revision | Route requirement of `taxonomy_term_revision.revert`; also gates whether the per-row **Revert** link is rendered in the list (`TermRevisionController::getRevisions`). |
| `delete term revision` | Delete taxonomy term revision | Route requirement of `taxonomy_term_revision.delete`; also gates the per-row **Delete** link in the list. |
| `view term revision data` | View taxonomy term revision data | Declared but not referenced in routing or code. The single-revision view route (`taxonomy_term_revision.view`) is gated by `_entity_access: taxonomy_term.view` instead. |

## Grant via Drush

```bash
drush role:perm:add content_editor 'view term revision list'
drush role:perm:add content_editor 'revert term revision'
drush role:perm:add content_admin  'delete term revision'
```

## Notes

- The revert/delete permissions are checked twice: once by the route, and again per row in the list
  controller so links only appear to users who can act on them.
- Creating revisions is not permission-gated — see [../hooks/hooks.md](../hooks/hooks.md); every term
  save creates a new revision regardless of these permissions.
