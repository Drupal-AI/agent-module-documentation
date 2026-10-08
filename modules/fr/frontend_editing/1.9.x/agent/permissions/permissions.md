<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `frontend_editing.permissions.yml` (five permissions):

| Permission | Gates | Notes |
|---|---|---|
| `access frontend editing` | Using the frontend editor at all — the `frontend_editing.form` and `frontend_editing.toggle` routes, opening the sidebar, editing fields. | The baseline permission an editor needs. |
| `administer frontend editing` | The three admin config forms under `/admin/config/frontend-editing`. | `restrict access: true` (trusted/admin only). |
| `move paragraphs` | The up/down move action links (`frontend_editing.paragraph_up` / `paragraph_down`). | Checked together with `paragraphs_edit` access. |
| `add paragraphs` | The add / add-before controls (`frontend_editing.paragraph_add*`). | |
| `delete paragraphs` | The delete action link (`frontend_editing.paragraph_delete`). | |

## Typical grants

- A content editor role: `access frontend editing` + `move/add/delete paragraphs` (plus the
  usual core "edit" permissions on the target content, since forms still run normal entity
  access).
- A site builder/admin role: also `administer frontend editing`.

Paragraph actions are access-checked by controller methods
(`FrontendEditingController::accessUp/accessDown/accessAdd/accessDelete`) which combine these
permissions with `paragraphs_edit` lineage access and the module's access **events** (see
[../hooks/hooks-and-events.md](../hooks/hooks-and-events.md)), so granting the permission is
necessary but the event subscribers can still deny a specific action.

```bash
drush role:perm:add editor 'access frontend editing'
drush role:perm:add editor 'move paragraphs'
drush role:perm:add editor 'add paragraphs'
drush role:perm:add editor 'delete paragraphs'
```
