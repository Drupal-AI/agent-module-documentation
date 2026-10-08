# Permissions

Defined via `permission_callbacks` in `checklistapi.permissions.yml`
(`ChecklistapiPermissions`) — a fixed universal set plus a pair generated **per checklist**.

## Universal permissions

| Permission | Gates |
|---|---|
| `view checklistapi checklists report` | The **Checklists** report page at `/admin/reports/checklistapi` (route `checklistapi.report`). |
| `view any checklistapi checklist` | Read-only access to view items and saved progress on **all** checklists. |
| `edit any checklistapi checklist` | Check/uncheck items, save, and clear progress on **all** checklists. |

## Per-checklist permissions (auto-generated)

For every checklist ID returned by `hook_checklistapi_checklist_info()`, two permissions are
generated (titled with the checklist's `#title`):

| Permission | Gates |
|---|---|
| `view {id} checklistapi checklist` | Read-only access to that one checklist. |
| `edit {id} checklistapi checklist` | Check/uncheck, save, and clear that one checklist. |

## Access logic

`checklistapi_checklist_access($id, $operation)` resolves access; the dynamic checklist routes
use the `_checklistapi_access` requirement (service `access_check.checklistapi`). For a given
checklist:

- **view** = `view any checklistapi checklist` **OR** `view {id} checklistapi checklist`
- **edit** = `edit any checklistapi checklist` **OR** `edit {id} checklistapi checklist`
- **any**  = view OR edit

So a role granted only `edit {id} checklistapi checklist` can both view and edit that
checklist, but no others.

```
drush role:perm:add site_manager 'view my_checklist checklistapi checklist'
drush role:perm:add site_manager 'edit any checklistapi checklist'
```
