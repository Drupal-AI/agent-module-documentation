# Permissions

Defined in `entity_usage_node_delete_stop.permissions.yml`.

| Permission (label) | Machine name | Effect |
| --- | --- | --- |
| Skip the node deletion stop | `skip node delete stop` | User can delete used nodes regardless of Entity Usage — the delete-confirm-form stop is not applied to them. |

- The stop in `hook_form_node_confirm_form_alter()` only fires for users **without** this
  permission (`!\Drupal::currentUser()->hasPermission('skip node delete stop')`). Granting it
  is the intended escape hatch, e.g. for administrators or trusted editors.
- The permission is **not** flagged `restrict access`; grant it to any role that should be
  exempt from the deletion block.

Grant via Drush:

```bash
drush role:perm:add administrator 'skip node delete stop'
```
