<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `user_history.permissions.yml`.

| Permission | Restrict | Gates |
|---|---|---|
| `administer user_history entities` | `restrict access: true` | Settings form (`/admin/structure/user_history/settings`); batch initialise/update/archive/restore forms; the admin list view (`/user_history/list`); entity `admin_permission`. |
| `view user_history entities` | — | Canonical record page `/user_history/{user_history}`; the "History" tab on user profiles (`/user/{user}/history`); the `user_history` view. |
| `add user_history entities` | — | Defined and **auto-granted to the `authenticated` role on install** (`user_history_install()`), but inert: `UserHistoryAccessControlHandler::checkCreateAccess()` returns `forbidden`, so no history record can be created via the entity API. |
| `edit user_history entities` | — | Defined but inert: the `update` operation is hard-forbidden by the access handler. |
| `delete user_history entities` | — | Defined but inert: the `delete` operation is hard-forbidden by the access handler. |

## Access model

`UserHistoryAccessControlHandler::checkAccess()`:
- `view` → allowed if the account has `view user_history entities`.
- `update` → always `forbidden` ("User history records may not be changed!").
- `delete` → always `forbidden` ("User history records may not be deleted!").
- `checkCreateAccess()` → always `forbidden` ("...may not be added manually!").

Records are only ever created by the module's own `hook_user_*` implementations and batch
processes, and only ever removed by `hook_cron` pruning and the archive batch — never through the
CRUD UI.

## "manually …" permissions in routing.yml

The dummy routes `entity.user_history.add_form` / `edit_form` / `delete_form` (and the module's
`user_history.add_form` / `edit_form` / `delete_form`) require `manually add user_history entities`,
`manually edit user_history entities`, `manually delete user_history entities`. **These strings are
not declared in `user_history.permissions.yml`**, so no role can ever hold them — the manual
add/edit/delete forms are permanently inaccessible by design.
